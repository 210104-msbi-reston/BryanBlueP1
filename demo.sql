
select * from ProductTypes
select * from Customers

select * from ProductionHouses
select * from Warehouses
select * from Distributors
select * from SubDistributors
select * from ChannelPartners
select * from Zones
select * from Stores
--Create a new Product
--Parameters: Production house Id, Product Id, Quantity
EXEC MakeNewProducts 4, 4, 1

select * from ViewProducts

--MoveProduct
--Parameters Product Serial Num, Destination
EXEC MoveProduct 16, 'Distributor:2'
EXEC MoveProduct 16, 'SubDistributor:2'
EXEC MoveProduct 16, 'ChannelProvider:2'
EXEC MoveProduct 16, 'Zones:2'
EXEC MoveProduct 16, 'Stores:2'

select * from ProductHistory

--Make order
--Parameters:StoreId, CustomerId, ProductSerialNumber
EXEC MakeOrder 2, 1, 14

select * from ViewOrders

--Return Product
--Parameters:Order Id, Return Location, Reason
EXEC ReturnProduct 5, 'Store:1', 'Faulty Product'

select * from Returns
select * from ProductHistory
