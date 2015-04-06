module Main where

import Text.XML.HXT.Core

rfcChildren :: IOSArrow XmlTree XmlTree
rfcChildren = isElem >>> hasName "rfc" >>> getChildren

front :: IOSArrow XmlTree XmlTree
front = rfcChildren >>> isElem >>> hasName "front" >>> getChildren

getAuthor :: IOSArrow XmlTree String
getAuthor =
    front
    >>>
    isElem >>> hasName "author"
    >>>
    getText

processor :: FilePath -> IOSArrow XmlTree XmlTree
processor filename =
    readDocument [withValidate no] filename
    -- >>>
    -- putXmlTree "-"

main :: IO ()
main = do
    resume2 <- runX $ processor "resume.xml"
                    >>> getChildren
                    >>> isElem
                    >>> hasName "rfc"
                    >>> getChildren
                    >>> isElem
                    >>> hasName "front"
                    >>> getChildren
                    >>> isElem
                    >>> hasName "author"
                    >>> getAttrl
    print resume2
