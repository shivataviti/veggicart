using vegi.cart from '../db/schema';

service VegiCartService {

  entity Customers as projection on cart.Customers;
  entity Products  as projection on cart.Products;
  entity Inventory as projection on cart.Inventory;
  entity Orders    as projection on cart.Orders;
  entity Payments  as projection on cart.Payments;

}