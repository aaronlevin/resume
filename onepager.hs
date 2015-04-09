module Main where

import Text.XML.HXT.Core

-- | Several newtype wrappers around sections of the. The convention is that
-- these newtype wrappers wrap the "children" elements. I.e.
-- <front>{ ... this is XmlTree in newtype Wrapper Front .. }</front>
-- so, when you're given a Front you don't need to call `getChildren`
-- right away.
newtype Abstract = Abstract { unAbstract :: String  } deriving (Show)
newtype Author   = Author   { unAuthor   :: String  } deriving (Show)
newtype Front    = Front    { unFront    :: XmlTree } deriving (Show)
newtype Middle   = Middle   { unMiddle   :: XmlTree } deriving (Show)
newtype RFC      = RFC      { unRFC      :: XmlTree } deriving (Show)

-- | flatten structures like:
-- <t><list><t>xxxx</t></list></t>
deepT :: IOSArrow XmlTree String
deepT = hasName "t" <+> hasName "list"
        >>> getChildren
        >>> (isElem `guards` deepT `orElse` getText)

-- | Transform the top-level XmlTree into an RFC
rfc :: IOSArrow XmlTree RFC
rfc = isElem
      >>> getChildren
      >>> hasName "rfc"
      >>> getChildren
      >>> arr RFC

-- | arrow to transform from RFC to Front elements.
front :: IOSArrow RFC Front
front = arr unRFC
        >>> hasName "front"
        >>> getChildren
        >>> arr Front

-- | arrow to transform from RFC to Middle elements.
middle :: IOSArrow RFC Middle
middle = arr unRFC
        >>> hasName "middle"
        >>> getChildren
        >>> arr Middle

-- | arrow to transform Front xml elements into the author string
author :: IOSArrow Front Author
author = arr unFront
        >>> hasName "author"
        >>> getAttrValue "fullname"
        >>> arr Author

-- | arrow to transform Front xml elements into the abstract.
abstract :: IOSArrow Front Abstract
abstract = arr unFront
        >>> hasName "abstract"
        >>> getChildren
        >>> hasName "t"
        >>> getChildren
        >>> getText
        >>> arr Abstract

-- | open a file and produce an `XmlTree`
processor :: FilePath -> IOSArrow XmlTree XmlTree
processor = readDocument [withValidate no]

-- | main
main :: IO ()
main = do
    resume2 <- runX $ processor "resume.xml"
                    >>> rfc
                    >>> front
                    >>> (arr unFront >>> hasName "abstract" >>> getChildren >>> deepT)
                    -- >>> abstract
    print resume2
