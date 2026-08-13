import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: ProfileScreen()));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definimos algunos colores y constantes de estilo para consistencia
    const Color _scaffoldBackgroundColor = Color(0xFFF6F8FA);
    const Color _white = Colors.white;
    const Color _primaryText = Colors.black;
    const Color _secondaryText = Color(0xFF818C99);
    const double _standardPadding = 20.0;

    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      // SafeArea para no colisionar con el notch o la barra de estado
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _standardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Título de la App Bar customizado
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700, // Bold
                      color: _primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // 2. Sección del Avatar con botón de edición
                const Center(
                  child: ProfileAvatarSection(),
                ),
                const SizedBox(height: 35),

                // 3. Tarjeta de Información Personal
                const ProfileInfoCard(
                  title: 'Personal info',
                  showEdit: true,
                  children: [
                    InfoItem(
                      icon: Icons.person_outline,
                      label: 'Name',
                      value: 'Terry Melton',
                    ),
                    InfoItem(
                      icon: Icons.email_outlined,
                      label: 'E-mail',
                      value: 'melton89@gmail.com',
                    ),
                    InfoItem(
                      icon: Icons.phone_android_outlined,
                      label: 'Phone number',
                      value: '+1 201 555-0123',
                    ),
                    InfoItem(
                      icon: Icons.home_outlined,
                      label: 'Home address',
                      value: '70 Rainey Street, Apartment 146, Austin TX 78701',
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // 4. Tarjeta de Información de Cuenta (vacía para replicar)
                const ProfileInfoCard(
                  title: 'Account info',
                  showEdit: false,
                  children: [],
                ),
                const SizedBox(height: 100), // Espacio extra para el scroll antes del nav bar
              ],
            ),
          ),
        ),
      ),
      // 5. Barra de Navegación Inferior (BottomNavigationBar)
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

// 2. Avatar con borde y botón de edición superpuesto
class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // El círculo del avatar con la imagen
        Container(
          padding: const EdgeInsets.all(4), // Espacio para el borde exterior
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // Fondo del borde
          ),
          child: const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/user_avatar.png'),
            // NOTA: Reemplaza con tu imagen local o NetworkImage si prefieres
            backgroundColor: Color(0xFFF6F8FA),
          ),
        ),
        // Botón de edición flotante
        Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.edit_outlined,
              size: 24,
              color: Color(0xFF818C99), // Un gris intermedio
            ),
          ),
        ),
      ],
    );
  }
}

//  Contenedor de la Tarjeta de Información 
class ProfileInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool showEdit;

  const ProfileInfoCard({
    Key? key,
    required this.title,
    required this.children,
    this.showEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Sutil sombreado para dar profundidad
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la sección
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                if (showEdit)
                  const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF818C99),
                    ),
                  ),
              ],
            ),
          ),
          // El contenido de la lista
          ...children,
          // Padding
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Elemento individual de la lista de información
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono principal
              Icon(
                icon,
                size: 26,
                color: const Color(0xFF818C99),
              ),
              const SizedBox(width: 16),
              // Etiquetas de texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label (Gris)
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF818C99),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Valor (Negro)
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.3, // Altura de línea para múltiples líneas (como en la dirección)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
      ],
    );
  }
}

// BARRA DE NAVEGACIÓN
class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    int _selectedIndex = 4;
    const Color _unselectedItemColor = Color(0xFF818C99);
    // Activo o en línea
    const Color _selectedItemColor = Color(0xFF7CB342); // Un verde oliva/lima suave

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0, // Poner arriba navbar
        backgroundColor: Colors.transparent, 
        type: BottomNavigationBarType.fixed, // Espaciado
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_outlined),
            activeIcon: Icon(Icons.swap_horiz),
            label: 'Transfer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // El icono de perfil en versión miniatura 
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // Color anillo verde
                    color: _selectedItemColor,
                  ),
                ),
                const CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage('assets/images/user_avatar.png'),
                 
                ),
              ],
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}