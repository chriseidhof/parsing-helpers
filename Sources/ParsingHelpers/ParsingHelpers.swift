import Foundation

extension Character {
    public var isDecimalDigit: Bool {
        return self.isHexDigit && self.hexDigitValue! < 10 // todo?
    }
}

extension RangeReplaceableCollection where Element: Comparable {
    /// Removes the given prefix from the start of this collection, if it exists. Returns `true` if the prefix was removed, `false` otherwise.
    mutating public func remove<S>(prefix: S) -> Bool where S: Sequence, S.Element == Element {
        var ix = startIndex
        var count = 0
        for el in prefix {
            guard ix < endIndex, self[ix] == el else { return false }
            self.formIndex(after: &ix)
            count += 1
        }
        
        removeFirst(count) // todo: benchmark this. it probably isn't very efficient?
        
        return true
    }
}

extension RangeReplaceableCollection {
    /// Removes from the start of this collection while the condition is true. The removed elements are returned.
    @discardableResult mutating public func remove(while cond: (Element) -> Bool) -> SubSequence {
        guard let end = firstIndex(where: { !cond($0) }) else {
            let remainder = self[...]
            removeAll()
            return remainder
        }
        let result = self[..<end]
        removeFirst(result.count)
        return result
    }
    
}

extension RangeReplaceableCollection where Element == Character {
    /// Removes any leading white space from the start of this collection.
    mutating public func skipWS() {
        remove(while: { $0.isWhitespace })
    }
    
    /// Removes any leading white space (but not newlines) from the start of this collection.
    mutating public func skipWSWithoutNewlines() {
        remove(while: { $0.isWhitespace && !$0.isNewline })
    }
}

