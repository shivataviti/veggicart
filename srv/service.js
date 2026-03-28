module.exports = (srv) => {

  const { Orders, Inventory } = srv.entities;

  // Before creating order → check inventory
  srv.before('CREATE', 'Orders', async (req) => {

    const items = req.data.items;

    for (let item of items) {

      const stock = await SELECT.one.from(Inventory)
        .where({ product_ID: item.product_ID });

      if (!stock || stock.quantity < item.quantity) {
        req.error(400, `Insufficient stock for product ${item.product_ID}`);
      }

      // Reduce stock
      await UPDATE(Inventory)
        .set({ quantity: stock.quantity - item.quantity })
        .where({ product_ID: item.product_ID });
    }

  });

};