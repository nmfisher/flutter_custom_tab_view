import 'package:custom_tab_view/custom_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Tab View Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Custom Tab View - Styling Examples',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 1),
            // Tab views for each example
            Expanded(
              child: DefaultTabController(
                length: _examples.length,
                child: Column(
                  children: [
                    // Top tab bar for selecting examples
                    _buildExampleTabBar(context),
                    const Divider(height: 1),
                    // Content area
                    Expanded(
                      child: TabBarView(
                        children: _examples
                          .map((example) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: example.builder(context),
                          ))
                          .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleTabBar(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Builder(
        builder: (builderContext) {
          final tabController = DefaultTabController.of(builderContext);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: _examples.map((example) {
                final index = _examples.indexOf(example);
                return _ExampleTabButton(
                  title: example.title,
                  icon: example.icon,
                  onTap: () => tabController.animateTo(index),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _ExampleTabButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ExampleTabButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_ExampleTabButton> createState() => _ExampleTabButtonState();
}

class _ExampleTabButtonState extends State<_ExampleTabButton> {
  bool _isHovered = false;
  TabController? _tabController;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = _examples.indexWhere((e) => e.title == widget.title);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newTabController = DefaultTabController.of(context);
    if (_tabController != newTabController) {
      _tabController?.removeListener(_onTabChanged);
      _tabController = newTabController;
      _tabController!.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = _tabController?.index == _index;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : (_isHovered ? Theme.of(context).colorScheme.surfaceContainerHighest : null),
            borderRadius: BorderRadius.circular(8),
            border: isSelected
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: isSelected ? Theme.of(context).colorScheme.primary : null),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ////////////////////////////////////////////////////////////////////////////
// EXAMPLES
// ////////////////////////////////////////////////////////////////////////////

class Example {
  final String title;
  final String description;
  final IconData icon;
  final Widget Function(BuildContext) builder;

  const Example({
    required this.title,
    required this.description,
    required this.icon,
    required this.builder,
  });
}

final List<Example> _examples = [
  Example(
    title: 'Dark Theme',
    description: 'Using the preset dark() theme',
    icon: Icons.dark_mode,
    builder: (context) => const DarkThemeExample(),
  ),
  Example(
    title: 'Light Theme',
    description: 'Using the preset light() theme',
    icon: Icons.light_mode,
    builder: (context) => const LightThemeExample(),
  ),
  Example(
    title: 'Blue Theme',
    description: 'Using the preset blue() theme',
    icon: Icons.palette,
    builder: (context) => const BlueThemeExample(),
  ),
  Example(
    title: 'Custom Colors',
    description: 'Using individual color parameters (backward compatible)',
    icon: Icons.color_lens,
    builder: (context) => const CustomColorsExample(),
  ),
  Example(
    title: 'Theme Override',
    description: 'Preset theme with individual color overrides',
    icon: Icons.tune,
    builder: (context) => const ThemeOverrideExample(),
  ),
  Example(
    title: 'Custom Mix Style',
    description: 'Creating a completely custom theme with Mix',
    icon: Icons.brush,
    builder: (context) => const CustomMixStyleExample(),
  ),
  Example(
    title: 'Green Theme',
    description: 'A custom green preset theme',
    icon: Icons.eco,
    builder: (context) => const GreenThemeExample(),
  ),
  Example(
    title: 'Custom Header',
    description: 'Using tabHeaderLayout to customize the tab bar',
    icon: Icons.dashboard_customize,
    builder: (context) => const CustomHeaderExample(),
  ),
];

// ////////////////////////////////////////////////////////////////////////////
// DARK THEME EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class DarkThemeExample extends StatelessWidget {
  const DarkThemeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView(
      theme: WindowsStyleTabViewTheme.dark(),
      tabs: [
        WindowsStyleTab(
          title: 'Home',
          icon: Icons.home,
          content: _buildContent('Dark Theme - Home', Colors.blue),
        ),
        WindowsStyleTab(
          title: 'Search',
          icon: Icons.search,
          content: _buildContent('Dark Theme - Search', Colors.purple),
        ),
        WindowsStyleTab(
          title: 'Profile',
          icon: Icons.person,
          content: _buildContent('Dark Theme - Profile', Colors.green),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using WindowsStyleTabViewTheme.dark()'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// LIGHT THEME EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class LightThemeExample extends StatelessWidget {
  const LightThemeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView(
      theme: WindowsStyleTabViewTheme.light(),
      tabs: [
        WindowsStyleTab(
          title: 'Dashboard',
          icon: Icons.dashboard,
          content: _buildContent('Light Theme - Dashboard', Colors.orange),
        ),
        WindowsStyleTab(
          title: 'Analytics',
          icon: Icons.analytics,
          content: _buildContent('Light Theme - Analytics', Colors.teal),
        ),
        WindowsStyleTab(
          title: 'Reports',
          icon: Icons.assessment,
          content: _buildContent('Light Theme - Reports', Colors.indigo),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using WindowsStyleTabViewTheme.light()'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// BLUE THEME EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class BlueThemeExample extends StatelessWidget {
  const BlueThemeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView(
      theme: WindowsStyleTabViewTheme.blue(),
      tabs: [
        WindowsStyleTab(
          title: 'Inbox',
          icon: Icons.inbox,
          content: _buildContent('Blue Theme - Inbox', Colors.lightBlue),
        ),
        WindowsStyleTab(
          title: 'Sent',
          icon: Icons.send,
          content: _buildContent('Blue Theme - Sent', Colors.blue),
        ),
        WindowsStyleTab(
          title: 'Drafts',
          icon: Icons.drafts,
          content: _buildContent('Blue Theme - Drafts', Colors.blueAccent),
        ),
        WindowsStyleTab(
          title: 'Archive',
          icon: Icons.archive,
          content: _buildContent('Blue Theme - Archive', Colors.indigo),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using WindowsStyleTabViewTheme.blue()'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// CUSTOM COLORS EXAMPLE (Backward Compatible)
// ////////////////////////////////////////////////////////////////////////////

class CustomColorsExample extends StatelessWidget {
  const CustomColorsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView.withDefaults(
      tabBarBackgroundColor: const Color(0xFF1A1A2E),
      tabBarBorderColor: const Color(0xFF16213E),
      selectedTabColor: const Color(0xFFE94560),
      unselectedTabColor: const Color(0xFF1A1A2E),
      selectedTabTextColor: Colors.white,
      unselectedTabTextColor: const Color(0xFFE94560).withValues(alpha: 0.7),
      tabs: [
        WindowsStyleTab(
          title: 'Music',
          icon: Icons.music_note,
          content: _buildContent('Custom Colors - Music', const Color(0xFFE94560)),
        ),
        WindowsStyleTab(
          title: 'Movies',
          icon: Icons.movie,
          content: _buildContent('Custom Colors - Movies', const Color(0xFF0F3460)),
        ),
        WindowsStyleTab(
          title: 'Games',
          icon: Icons.sports_esports,
          content: _buildContent('Custom Colors - Games', const Color(0xFF533483)),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using individual color parameters (backward compatible)'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// THEME OVERRIDE EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class ThemeOverrideExample extends StatelessWidget {
  const ThemeOverrideExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView(
      theme: WindowsStyleTabViewTheme.dark(),
      // Override the selected tab color with a custom color
      selectedTabColor: Colors.deepOrange,
      selectedTabTextColor: Colors.white,
      tabs: [
        WindowsStyleTab(
          title: 'Settings',
          icon: Icons.settings,
          content: _buildContent('Theme Override - Settings', Colors.deepOrange),
        ),
        WindowsStyleTab(
          title: 'Security',
          icon: Icons.security,
          content: _buildContent('Theme Override - Security', Colors.red),
        ),
        WindowsStyleTab(
          title: 'Privacy',
          icon: Icons.privacy_tip,
          content: _buildContent('Theme Override - Privacy', Colors.orange),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Dark theme with selectedTabColor override'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// CUSTOM MIX STYLE EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class CustomMixStyleExample extends StatelessWidget {
  const CustomMixStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a completely custom theme using Mix
    final customTheme = WindowsStyleTabViewTheme(
      tabBarStyle: $box
          .height(32)
          .paddingOnly(left: 12, top: 6)
          .color(const Color(0xFF2C2C54))
          .borderBottom(color: const Color(0xFF474787), width: 2),
      tabStyle: $box
          .height(26)
          .paddingX(12)
          .paddingY(3)
          .borderRadiusTopLeft(const Radius.circular(6))
          .borderRadiusTopRight(const Radius.circular(6)),
      selectedTabBoxStyle: $box
          .color(const Color(0xFF474787))
          .borderTop(color: const Color(0xFF706FD3), width: 2)
          .borderLeft(color: const Color(0xFF706FD3), width: 2)
          .borderRight(color: const Color(0xFF706FD3), width: 2),
      unselectedTabBoxStyle: $box.color(const Color(0xFF2C2C54)),
      selectedTabTextStyle: $text.style.color(Colors.white).fontSize(13),
      unselectedTabTextStyle: $text.style.color(const Color(0xFFB4B4B4)).fontSize(13),
      selectedTabIconStyle: $icon.size(14).color(Colors.white),
      unselectedTabIconStyle: $icon.size(14).color(const Color(0xFFB4B4B4)),
    );

    return WindowsStyleTabView(
      theme: customTheme,
      tabs: [
        WindowsStyleTab(
          title: 'Explore',
          icon: Icons.explore,
          content: _buildContent('Custom Mix Style - Explore', const Color(0xFF706FD3)),
        ),
        WindowsStyleTab(
          title: 'Trending',
          icon: Icons.trending_up,
          content: _buildContent('Custom Mix Style - Trending', const Color(0xFF474787)),
        ),
        WindowsStyleTab(
          title: 'Favorites',
          icon: Icons.favorite,
          content: _buildContent('Custom Mix Style - Favorites', const Color(0xFF706FD3)),
        ),
        WindowsStyleTab(
          title: 'Library',
          icon: Icons.library_books,
          content: _buildContent('Custom Mix Style - Library', const Color(0xFF474787)),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using completely custom Mix styles'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// GREEN THEME EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class GreenThemeExample extends StatelessWidget {
  const GreenThemeExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom green theme
    final greenTheme = WindowsStyleTabViewTheme(
      tabBarStyle: $box
          .height(28)
          .paddingOnly(left: 8, top: 4)
          .color(const Color(0xFF1B4D3E))
          .borderBottom(color: const Color(0xFF0F2B23), width: 1),
      tabStyle: $box
          .height(24)
          .paddingX(8)
          .paddingY(2)
          .borderRadiusTopLeft(const Radius.circular(3))
          .borderRadiusTopRight(const Radius.circular(3)),
      selectedTabBoxStyle: $box
          .color(const Color(0xFF2D6A4F))
          .borderTop(color: const Color(0xFF0F2B23), width: 1)
          .borderLeft(color: const Color(0xFF0F2B23), width: 1)
          .borderRight(color: const Color(0xFF0F2B23), width: 1),
      unselectedTabBoxStyle: $box.color(const Color(0xFF1B4D3E)),
      selectedTabTextStyle: $text.style.color(Colors.white).fontSize(11),
      unselectedTabTextStyle: $text.style.color(const Color(0xFF95D5B2)).fontSize(11),
      selectedTabIconStyle: $icon.size(12).color(Colors.white),
      unselectedTabIconStyle: $icon.size(12).color(const Color(0xFF95D5B2)),
    );

    return WindowsStyleTabView(
      theme: greenTheme,
      tabs: [
        WindowsStyleTab(
          title: 'Nature',
          icon: Icons.nature,
          content: _buildContent('Green Theme - Nature', const Color(0xFF2D6A4F)),
        ),
        WindowsStyleTab(
          title: 'Forest',
          icon: Icons.forest,
          content: _buildContent('Green Theme - Forest', const Color(0xFF40916C)),
        ),
        WindowsStyleTab(
          title: 'Plants',
          icon: Icons.local_florist,
          content: _buildContent('Green Theme - Plants', const Color(0xFF52B788)),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using custom green Mix theme'),
      ],
    ),
  );
}

// ////////////////////////////////////////////////////////////////////////////
// CUSTOM HEADER EXAMPLE
// ////////////////////////////////////////////////////////////////////////////

class CustomHeaderExample extends StatelessWidget {
  const CustomHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowsStyleTabView(
      theme: WindowsStyleTabViewTheme.dark(),
      tabHeaderLayout: (context, tabs, selectedIndex, buildTab) => Row(
        children: [
          // First two tabs
          buildTab(0, tabs[0]),
          Box(style: $box.width(2)),
          buildTab(1, tabs[1]),
          // Spacer to push the menu to the right
          const Spacer(),
          // Custom menu button
          const _CustomMenuButton(
            items: [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 18),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18),
                    SizedBox(width: 12),
                    Text('About'),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 12),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      tabs: [
        WindowsStyleTab(
          title: 'Tab One',
          icon: Icons.tab,
          content: _buildContent('Custom Header - Tab One', Colors.blue),
        ),
        WindowsStyleTab(
          title: 'Tab Two',
          icon: Icons.tab,
          content: _buildContent('Custom Header - Tab Two', Colors.purple),
        ),
      ],
    );
  }

  Widget _buildContent(String title, Color color) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.preview, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Using tabHeaderLayout with a custom menu button'),
      ],
    ),
  );
}

class _CustomMenuButton extends StatelessWidget {
  final List<PopupMenuEntry> items;

  const _CustomMenuButton({required this.items});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Menu',
      itemBuilder: (context) => items,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_vert, size: 18),
            SizedBox(width: 4),
            Text('Menu', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
