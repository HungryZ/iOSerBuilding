//
//  BinaryTree.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2022/3/5.
//

class BinaryTree {
    
    enum TraverseWay {
        case preorder
        case inorder
        case postorder
    }
    
    var data: Character
    
    var leftChild: BinaryTree?
    
    var rightChild: BinaryTree?
    
    init(_ data: Character) {
        self.data = data
    }
    
    static func create(_ order: String) -> BinaryTree? {
        TreeCreator.create(order: order)
    }
    
    func traverse(_ way: TraverseWay) {
        traverse(tree: self, way: way)
    }
    
    private func traverse(tree: BinaryTree?, way: TraverseWay) {
        guard let tree = tree else {
            print("#", terminator: "")
            return
        }
        if way == .preorder {
            print(tree.data, terminator: "")
        }
        traverse(tree: tree.leftChild, way: way)
        if way == .inorder {
            print(tree.data, terminator: "")
        }
        traverse(tree: tree.rightChild, way: way)
        if way == .postorder {
            print(tree.data, terminator: "")
        }
    }
}

private class TreeCreator {
    
    let order: String
    var index = -1
    
    init (order: String) {
        self.order = order
    }
    
    /// 使用前序遍历结果来创建二叉树
    /// - Parameter order: 前序遍历结果 "124##5##36##7##" #代表空节点
    static func create(order: String) -> BinaryTree? {
        TreeCreator(order: order).create()
    }
    
    func create() -> BinaryTree? {
        index += 1
        guard let char = order.char(atIndex: index), char != "#" else { return nil }
        
        let tree = BinaryTree(char)
        tree.leftChild = create()
        tree.rightChild = create()
        
        return tree
    }
}

extension String {
    
    func char(atIndex n: String.IndexDistance) -> Character? {
        guard n < count else { return nil }
        
        return self[index(startIndex, offsetBy: n)]
    }
}
