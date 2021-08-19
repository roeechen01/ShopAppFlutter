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
  final initValues = {
    'title': '',
    'price': '0',
    'description': '',
    'imageUrl': '',
  };
  bool isInit = true;
  bool isLoading = false;

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        editedProduct = Provider.of<Products>(context).findById(id);
        initValues['title'] = editedProduct.title;
        initValues['price'] = editedProduct.price.toString();
        initValues['description'] = editedProduct.description;
        imageUrlController.text = editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(updateImage);
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateImage() {
    if (!imageUrlController.text.startsWith('http') &&
        !imageUrlController.text.startsWith('https')) return;
    setState(() {});
  }

  Future<void> save() async {
    final validation = _form.currentState.validate();
    if (validation) {
      _form.currentState.save();
      if (editedProduct.id == null) {
        setState(() {
          isLoading = true;
        });
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(editedProduct);
        } catch (error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Bug'),
              actions: [
                FlatButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      setState(() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        isLoading = false;
                      });
                    },
                    child: Text('Ok'))
              ],
            ),
          );
          print(error);
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = true;
        });
        await Provider.of<Products>(context, listen: false)
            .updateProduct(editedProduct.id, editedProduct);
        Navigator.of(context).pop();
      }
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _form,
                child: ListView(children: [
                  TextFormField(
                    initialValue: initValues['title'],
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(priceFocusNode),
                    onSaved: (value) => editedProduct = Product(
                        title: value,
                        description: editedProduct.description,
                        price: editedProduct.price,
                        imageUrl: editedProduct.imageUrl,
                        isFavorite: editedProduct.isFavorite,
                        id: editedProduct.id),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter input';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    initialValue: initValues['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    focusNode: priceFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(descriptionFocusNode),
                    onSaved: (value) => editedProduct = Product(
                        title: editedProduct.title,
                        description: editedProduct.description,
                        price: double.parse(value),
                        imageUrl: editedProduct.imageUrl,
                        isFavorite: editedProduct.isFavorite,
                        id: editedProduct.id),
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
                    initialValue: initValues['description'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: descriptionFocusNode,
                    onSaved: (value) => editedProduct = Product(
                        title: editedProduct.title,
                        description: value,
                        price: editedProduct.price,
                        imageUrl: editedProduct.imageUrl,
                        isFavorite: editedProduct.isFavorite,
                        id: editedProduct.id),
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
                            isFavorite: editedProduct.isFavorite,
                            id: editedProduct.id),
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
