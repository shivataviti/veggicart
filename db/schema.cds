namespace vegi.cart;

using { cuid, managed } from '@sap/cds/common';

entity Customers : cuid, managed {
  name     : String;
  phone    : String;
  location : String;
}

entity Products : cuid {
  name  : String;
  price : Decimal(10,2);
}

entity Inventory : managed {
key product  : Association to Products;
  quantity : Integer;
}

entity Orders : cuid, managed {
  customer : Association to Customers;
  status   : String;
  totalAmount : Decimal(10,2);
  items    : Composition of many OrderItems
             on items.order = $self;
}

entity OrderItems {
  key order   : Association to Orders;
  key product : Association to Products;
  quantity    : Integer;
  price       : Decimal(10,2);
}

entity Payments : cuid, managed {
  order  : Association to Orders;
  amount : Decimal(10,2);
  status : String; // PAID / UNPAID
}