import 'package:flutter/material.dart';
import 'package:flutter_masked_text3/flutter_masked_text3.dart';

import 'model/produto_model.dart';
import 'widgets/chip_info.dart';
import 'widgets/text_field_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista e Cadastro de Produto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.teal[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 28),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.teal),
          bodySmall: TextStyle(fontSize: 16, color: Colors.teal),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
            padding: MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            ),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.teal, fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.teal, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.teal, width: 2.5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        ),
      ),
      home: const ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<ProdutoModel> productData = [
    ProdutoModel(
      nome: 'Notebook Dell Inspiron 15',
      precoCompra: 3200.00,
      precoVenda: 3999.99,
      quantidade: 10,
      descricao: 'Notebook com Intel i5, 8GB RAM e SSD 256GB.',
      categoria: 'Eletrônicos',
      imagem:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=400&q=80',
      ativo: true,
      emPromocao: false,
      desconto: 0,
    ),
    ProdutoModel(
      nome: 'Tênis Esportivo Nike Revolution',
      precoCompra: 120.00,
      precoVenda: 199.90,
      quantidade: 25,
      descricao: 'Tênis confortável para corrida e caminhada.',
      categoria: 'Calçados',
      imagem:
          'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80',
      ativo: true,
      emPromocao: true,
      desconto: 15.0,
    ),
    ProdutoModel(
      nome: 'Chocolate ao Leite 90g',
      precoCompra: 3.50,
      precoVenda: 6.99,
      quantidade: 100,
      descricao: 'Chocolate ao leite delicioso, embalagem de 90g.',
      categoria: 'Alimentos',
      imagem:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      ativo: true,
      emPromocao: false,
      desconto: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista e Cadastro de Produto'),
        centerTitle: true,
        actions: const [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      body: ProductDetailsPage(productData: productData),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final List<ProdutoModel> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var produto = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormPage(),
            ),
          );
          if (produto != null) {
            setState(() {
              widget.productData.add(produto);
            });
          }
        },
        label: const Text(
          'Novo Produto',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 30),
        backgroundColor: Colors.teal,
      ),
      body: widget.productData.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto cadastrado.',
                style: TextStyle(fontSize: 22, color: Colors.teal, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: widget.productData.length,
              itemBuilder: (context, index) {
                final product = widget.productData[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Nome
                        Row(
                          children: [
                            const Icon(Icons.label, color: Colors.teal, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                product.nome,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        /// Imagem (se houver)
                        if (product.imagem != null && product.imagem.toString().isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.imagem!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Text('Imagem não carregada')),
                            ),
                          ),
                        if (product.imagem != null && product.imagem.toString().isNotEmpty)
                          const SizedBox(height: 18),

                        /// Preços e quantidade
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipInfoWidget(
                                  label: 'Compra R\$ ${product.precoCompra}',
                                  icon: Icons.shopping_cart),
                              const SizedBox(width: 12),
                              ChipInfoWidget(
                                  label: 'Venda R\$ ${product.precoVenda}',
                                  icon: Icons.attach_money),
                              const SizedBox(width: 12),
                              ChipInfoWidget(
                                  label: 'Qtd ${product.quantidade}', icon: Icons.inventory),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// Categoria
                        Row(
                          children: [
                            const Icon(Icons.category, color: Colors.teal, size: 24),
                            const SizedBox(width: 10),
                            Text(
                              'Categoria: ${product.categoria}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18, color: Colors.teal),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Descrição
                        Row(
                          children: [
                            const Icon(Icons.description, color: Colors.teal, size: 24),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text('Descrição: ${product.descricao}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 18, color: Colors.teal)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        /// Status
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(
                                product.ativo ? Icons.check_circle : Icons.cancel,
                                color: product.ativo ? Colors.green : Colors.red,
                                size: 26,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                product.ativo ? 'Ativo' : 'Inativo',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18, color: Colors.teal),
                              ),
                              const SizedBox(width: 18),
                              Icon(
                                product.emPromocao ? Icons.discount : Icons.price_check,
                                color: product.emPromocao ? Colors.orange : Colors.grey,
                                size: 26,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                product.emPromocao ? 'Em Promoção' : 'Sem Promoção',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18, color: Colors.teal),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.percent,
                                color: Colors.teal,
                                size: 26,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Desconto: ${product.desconto}%',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18, color: Colors.teal),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _productNameController = TextEditingController();
  final MoneyMaskedTextController _productPurchasePriceController = MoneyMaskedTextController(
    precision: 2,
  );
  final MoneyMaskedTextController _productSalePriceController = MoneyMaskedTextController(
    precision: 2,
  );

  final MoneyMaskedTextController _productQuantityController =
      MoneyMaskedTextController(precision: 0, decimalSeparator: '');
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productImageController = TextEditingController();
  bool _productActive = true;
  String _productCategory = 'Eletrônicos';
  bool _productOnSale = false;
  double _discountValue = 0.0;

  bool _isValidQuantity(String quantity) {
    return int.tryParse(quantity) != null && int.parse(quantity) > 0;
  }

  void _cadastraProduto() {
    if (_productNameController.text.isEmpty) {
      _showSnackbar('Nome do produto é obrigatório!');
      return;
    }
    if (_productPurchasePriceController.text.isEmpty) {
      _showSnackbar('Preço de compra inválido!');
      return;
    }
    if (_productSalePriceController.text.isEmpty) {
      _showSnackbar('Preço venda inválido!');
      return;
    }
    if (_productQuantityController.text.isEmpty ||
        !_isValidQuantity(_productQuantityController.text)) {
      _showSnackbar('Quantidade inválida!');
      return;
    }
    if (_productDescriptionController.text.isEmpty) {
      _showSnackbar('Descrição do produto é obrigatória!');
      return;
    }

    final newProduct = ProdutoModel(
      nome: _productNameController.text,
      precoCompra: _productPurchasePriceController.numberValue ?? 0,
      precoVenda: _productSalePriceController.numberValue ?? 0,
      quantidade: _productQuantityController.numberValue?.toInt() ?? 0,
      descricao: _productDescriptionController.text,
      categoria: _productCategory,
      imagem: _productImageController.text,
      ativo: _productActive,
      emPromocao: _productOnSale,
      desconto: _discountValue,
    );

    Navigator.pop(context, newProduct);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrando Produto',
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22.0),
        child: buildProductForm(),
      ),
      backgroundColor: Colors.teal[50],
    );
  }

  Widget buildProductForm() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informações do Produto',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextFieldWidget(
                controller: _productNameController,
                labelText: 'Nome do produto',
                hintText: 'Informe o nome do produto',
                icon: const Icon(Icons.label, color: Colors.teal, size: 26),
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productPurchasePriceController,
              labelText: 'Preço de compra',
              hintText: 'Informe o preço de compra',
              icon: const Icon(Icons.attach_money, color: Colors.teal, size: 26),
              keyboard: TextInputType.number,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productSalePriceController,
              labelText: 'Preço de venda',
              hintText: 'Informe o preço de venda',
              icon: const Icon(Icons.money, color: Colors.teal, size: 26),
              keyboard: TextInputType.number,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productQuantityController,
              labelText: 'Quantidade em estoque',
              hintText: 'Informe a quantidade em estoque',
              icon: const Icon(Icons.inventory, color: Colors.teal, size: 26),
              keyboard: TextInputType.number,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productDescriptionController,
              labelText: 'Descrição',
              hintText: 'Informe a descrição do produto',
              maxLines: 5,
              icon: const Icon(Icons.description, color: Colors.teal, size: 26),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Categoria',
                prefixIcon: const Icon(Icons.category, color: Colors.teal, size: 26),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _productCategory,
                  isExpanded: true,
                  style: const TextStyle(fontSize: 20, color: Colors.teal),
                  items: ['Eletrônicos', 'Roupas', 'Calçados', 'Alimentos']
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _productCategory = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productImageController,
              labelText: 'URL da imagem',
              hintText: 'Informe a imagem do produto',
              maxLines: 1,
              icon: const Icon(Icons.image, color: Colors.teal, size: 26),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Produto Ativo', style: TextStyle(fontSize: 20, color: Colors.teal)),
              value: _productActive,
              activeColor: Colors.teal,
              onChanged: (value) {
                setState(() {
                  _productActive = value!;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Produto em Promoção', style: TextStyle(fontSize: 20, color: Colors.teal)),
              value: _productOnSale,
              activeColor: Colors.teal,
              onChanged: (value) {
                setState(() {
                  _productOnSale = value;
                });
              },
            ),
            const SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Desconto (%)', style: TextStyle(fontSize: 20, color: Colors.teal)),
                Slider(
                  value: _discountValue,
                  min: 0,
                  max: 90,
                  divisions: 20,
                  label: '${_discountValue.round()}%',
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      _discountValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _cadastraProduto,
              icon: const Icon(Icons.save, color: Colors.white, size: 26),
              label: const Text(
                'Cadastrar Produto',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, null),
              icon: const Icon(Icons.cancel, color: Colors.white, size: 26),
              label: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}