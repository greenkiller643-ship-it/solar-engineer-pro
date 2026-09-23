import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SolarEngineerProApp());
}

class SolarEngineerProApp extends StatelessWidget {
  const SolarEngineerProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Engineer Pro',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      
      // Dynamic Day/Night Glassmorphism Themes
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFD97706),
          secondary: Color(0xFF0284C7),
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF59E0B),
          secondary: Color(0xFF38BDF8),
          surface: Color(0xFF1E293B),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const MainDashboardScreen(),
    );
  }
}

/// Main Dashboard representing the 8 Core Engineering Points
class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    LoadAndPshOverviewPage(),
    EquipmentCatalogPage(),
    PumpingAndHydraulicsPage(),
    WiringAndProtectionPage(),
    SldAndPdfPage(),
    FinancialDevisPage(),
    IotAndDiagnosticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solar Engineer Pro ☀️',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {
              // Trigger AR & LiDAR Scan / QR Verification
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Load & PSH',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop_outlined),
            selectedIcon: Icon(Icons.water_drop),
            label: 'Pumping',
          ),
          NavigationDestination(
            icon: Icon(Icons.electric_bolt_outlined),
            selectedIcon: Icon(Icons.electric_bolt),
            label: 'Wiring',
          ),
          NavigationDestination(
            icon: Icon(Icons.schema_outlined),
            selectedIcon: Icon(Icons.schema),
            label: 'SLD & PDF',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Devis & ROI',
          ),
          NavigationDestination(
            icon: Icon(Icons.sensors_outlined),
            selectedIcon: Icon(Icons.sensors),
            label: 'IoT & AR',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 1 & 2. LOAD PROFILE & PSH DATABASE MODULE
// ============================================================================
class LoadAndPshOverviewPage extends StatelessWidget {
  const LoadAndPshOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('1 & 2. الأحمال السكنية وقاعدة PSH'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('الموقع المختصر:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Chip(label: Text('Agadir (PSH: 5.6 kWh/m²/day)')),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('منحنى الاستهلاك الزمني (24h Load Curve)'),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: const Center(
                    child: Text('📊 رسم بياني تفاعلي لمنحنى التزامن وتيار البدء'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3. EQUIPMENT & BOM CATALOG MODULE
// ============================================================================
class EquipmentCatalogPage extends StatelessWidget {
  const EquipmentCatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('3. قاعدة بيانات العتاد المعتمدة (Tier-1)'),
        _buildCatalogTile('ألواح شمسية', 'Jinko, Trina, Canadian (585W - 700W N-Type TOPCon)', Icons.solar_power),
        _buildCatalogTile('بطاريات التخزين', 'Pylontech, Deye, BYD (LiFePO4 48V / GEL 200Ah)', Icons.battery_charging_full),
        _buildCatalogTile('المحولات العاكسة', 'Deye, Victron, Huawei, Voltronic (Hybrid/Off-Grid)', Icons.developer_board),
        _buildCatalogTile('الهندسة المدنية', 'حساب أكياس الأسمنت، الرمل، الحصى وشاسيه التثبيت', Icons.foundation),
      ],
    );
  }

  Widget _buildCatalogTile(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber.shade700, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

// ============================================================================
// 4. PUMPING & HYDRAULICS MODULE
// ============================================================================
class PumpingAndHydraulicsPage extends StatelessWidget {
  const PumpingAndHydraulicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('4. الضخ الشمسي والمواصفات الهيدروليكية'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.water, color: Colors.blue),
                  title: Text('حاسبة HMT المتقدمة (Darcy-Weisbach)'),
                  subtitle: Text('حساب الفقد الاحتكاكي بالأنابيب ومعامل الضغط الكلي'),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _MetricBadge(label: 'HMT الكلي', value: '120 m'),
                    _MetricBadge(label: 'التدفق اليومي', value: '45 m³/day'),
                    _MetricBadge(label: 'قدرة المضخة', value: '7.5 HP'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 5. WIRING, PROTECTION & EARTHING MODULE
// ============================================================================
class WiringAndProtectionPage extends StatelessWidget {
  const WiringAndProtectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('5. مقاسات الكابلات، قواطع الحماية والتأريض'),
        Card(
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.cable, color: Colors.red),
                title: Text('كابلات التيار المستمر (DC Cable Sizing)'),
                subtitle: Text('Solar Cable 6mm² - هبوط الجهد < 1.2%'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.shield, color: Colors.green),
                title: Text('نظام التأريض (Earthing System)'),
                subtitle: Text('مقاومة التربة الهدف < 10 Ω (2 Piquets de Terre)'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 6. SLD CANVAS & PDF EXPORT
// ============================================================================
class SldAndPdfPage extends StatelessWidget {
  const SldAndPdfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('6. المخطط الأحادي الخطي والتصدير (SLD & Technical Dossier)'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.slate.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              '📐 CustomPainter Single-Line Diagram (IEC 60617 Standard)',
              style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('تصدير الملف الفني المعتمد (PDF Technical Dossier)'),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ============================================================================
// 7. FINANCIAL DEVIS & ROI MODULE
// ============================================================================
class FinancialDevisPage extends StatelessWidget {
  const FinancialDevisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('7. عروض الأسعار والعائد المالي (Devis & Carbon Footprint)'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('تكلفة المشروع الإجمالية:', style: TextStyle(fontSize: 16)),
                    Text('48,500 DH', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('فترة استرداد رأس المال (ROI):'),
                    Chip(label: Text('2 سنتين و 8 أشهر')),
                  ],
                ),
                const Divider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('مشاركة عرض السعر فوراً عبر WhatsApp'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 8. IOT MONITORING & NEXT-GEN AR MODULE
// ============================================================================
class IotAndDiagnosticsPage extends StatelessWidget {
  const IotAndDiagnosticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader('8. لوحة IoT والواقع المعزز (AR / LiDAR Roofing)'),
        Card(
          color: Colors.blueGrey.shade900,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📡 قراءات المحول اللحظية (Modbus RS485)', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('إنتاج الألواح: 4.8 kW  |  جهد البطارية: 53.2 V', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.view_in_ar),
          label: const Text('تشغيل المسح ثلاثي الأبعاد والواقع المعزز (AR Scan)'),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ============================================================================
// HELPER WIDGETS
// ============================================================================
Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

class _MetricBadge extends StatelessWidget {
  final String label;
  final String value;
  const _MetricBadge({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
