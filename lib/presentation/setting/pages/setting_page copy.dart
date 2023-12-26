import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posfluttermd/data/datasources/auth_local_datasource.dart';
import 'package:posfluttermd/data/datasources/product_local_datasource.dart';
import 'package:posfluttermd/presentation/auth/pages/login_page.dart';
import 'package:posfluttermd/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:posfluttermd/presentation/home/bloc/product/product_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(const ProductEvent.fetch());
              },
              child: Text('Sync Data')),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) async {
                  await ProductLocalDatasource.instance.removeAllProduct();
                  await ProductLocalDatasource.instance
                      .insertAllProduct(_.products.toList());
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('sync data success')));
                },
              );
            },
            builder: (context, state) {
              return Divider();
            },
          ),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocalDataSource().removeAuthData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  });
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Text('Logout'),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
