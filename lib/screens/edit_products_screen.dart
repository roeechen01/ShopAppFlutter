import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit_products_screen';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();
  final imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  Product editedProduct =
      Product(id: null, description: '', imageUrl: '', title: '', price: 0);

  @override
  void initState() {
    imageUrlFocusNode.addListener(tentacion);
    super.initState();
  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(tentacion);
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  void tentacion() {
    if (!imageUrlController.text.startsWith('http') &&
        !imageUrlController.text.startsWith('https')) return;
    setState(() {});
  }

  void save() {
    final validation = _form.currentState.validate();
    if (validation) {
      _form.currentState.save();
      Provider.of<Products>(context, listen: false).addProduct(editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Product'),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: save)]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _form,
            child: ListView(children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(priceFocusNode),
                onSaved: (value) => editedProduct = Product(
                    title: value,
                    description: editedProduct.description,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    id: null),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter input';
                  else
                    return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(descriptionFocusNode),
                onSaved: (value) => editedProduct = Product(
                    title: editedProduct.title,
                    description: editedProduct.description,
                    price: double.parse(value),
                    imageUrl: editedProduct.imageUrl,
                    id: null),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter input';
                  if (double.tryParse(value) == null)
                    return 'Please enter a number';
                  if (double.parse(value) <= 0)
                    return 'Please enter a number greater than 0';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: descriptionFocusNode,
                onSaved: (value) => editedProduct = Product(
                    title: editedProduct.title,
                    description: value,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    id: null),
                validator: (value) {
                  if (value.length <= 10)
                    return 'Please enter text longer than 10 character';
                  else
                    return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: imageUrlController.text.isEmpty
                          ? Text('Enter Image URL')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                imageUrlController.text,
                              ))),
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: imageUrlController,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    focusNode: imageUrlFocusNode,
                    onSaved: (value) => editedProduct = Product(
                        title: editedProduct.title,
                        description: editedProduct.description,
                        price: editedProduct.price,
                        imageUrl: value,
                        id: null),
                    onFieldSubmitted: (_) => save(),
                    validator: (value) {
                      if (!value.startsWith('http') &&
                          !value.startsWith('https'))
                        return 'Please enter a valid URL';
                      else
                        return null;
                    },
                  ))
                ],
              )
            ])),
      ),
    );
  }
}
