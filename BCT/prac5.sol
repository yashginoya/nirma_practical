// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AgricultureSupplyChain {
    // Structure to represent a product's information
    struct Product {
        uint256 productId;
        string productName;
        address producer;
        uint256 timestamp;
        string location;
        bool isCertifiedOrganic;
    }

    // Mapping to store product information by product ID
    mapping(uint256 => Product) public products;

    // Event to log product creation
    event ProductCreated(uint256 indexed productId, string productName, address producer);

    // Function to create a new product entry
    function createProduct(
        uint256 _productId,
        string memory _productName,
        string memory _location,
        bool _isCertifiedOrganic
    ) public {
        require(products[_productId].productId == 0, "Product ID already exists");
        
        // Store product information
        Product memory newProduct = Product({
            productId: _productId,
            productName: _productName,
            producer: msg.sender,
            timestamp: block.timestamp,
            location: _location,
            isCertifiedOrganic: _isCertifiedOrganic
        });
        
        products[_productId] = newProduct;
        
        // Log the product creation
        emit ProductCreated(_productId, _productName, msg.sender);
    }

    // Function to get product details by product ID
    function getProductDetails(uint256 _productId) public view returns (
        string memory productName,
        address producer,
        uint256 timestamp,
        string memory location,
        bool isCertifiedOrganic
    ) {
        Product storage product = products[_productId];
        require(product.productId != 0, "Product ID does not exist");
        
        return (
            product.productName,
            product.producer,
            product.timestamp,
            product.location,
            product.isCertifiedOrganic
        );
    }
}