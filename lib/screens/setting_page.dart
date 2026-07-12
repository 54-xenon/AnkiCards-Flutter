import 'package:ankicards/service/afm_service.dart';
import 'package:ankicards/service/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:foundation_models_framework/foundation_models_framework.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AfmService _afmService = AfmService();
  final SettingsService _settingsService = SettingsService.instance;

  AvailabilityResponse? _availability;
  bool _isChecking = false;
  AiProvider _selectedProvider = AiProvider.gemini;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _checkAvailability();
  }

  Future<void> _loadSettings() async {
    final provider = await _settingsService.getAiProvider();
    if (mounted) setState(() => _selectedProvider = provider);
  }

  Future<void> _checkAvailability() async {
    setState(() => _isChecking = true);
    try {
      final result = await _afmService.checkAfm();
      if (mounted) setState(() => _availability = result);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('チェックに失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  Future<void> _onProviderChanged(AiProvider provider) async {
    await _settingsService.setAiProvider(provider);
    if (mounted) setState(() => _selectedProvider = provider);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Text(
              'AI機能',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            // 解説生成のプロバイダー選択
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        const Text(
                          '解説生成に使うAI',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'フラッシュカードの解説を自動生成するAIを選択します',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    RadioGroup<AiProvider>(
                      groupValue: _selectedProvider,
                      onChanged: (v) {
                        if (v == AiProvider.afm &&
                            _availability?.isAvailable != true) {
                          return;
                        }
                        _onProviderChanged(v!);
                      },
                      child: Column(
                        children: [
                          RadioListTile<AiProvider>(
                            value: AiProvider.gemini,
                            title: const Text('Gemini API'),
                            subtitle:
                                const Text('クラウド経由で生成（ネットワーク必要）'),
                            contentPadding: EdgeInsets.zero,
                          ),
                          Opacity(
                            opacity:
                                _availability?.isAvailable == true ? 1.0 : 0.5,
                            child: RadioListTile<AiProvider>(
                              value: AiProvider.afm,
                              title:
                                  const Text('オンデバイスAI (Apple Intelligence)'),
                              subtitle: Text(
                                _availability == null
                                    ? '確認中...'
                                    : _availability!.isAvailable
                                        ? 'オフラインで生成可能'
                                        : '利用不可: ${_availability!.errorMessage ?? "このデバイスは対応していません"}',
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // AFM利用可否ステータス
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone_iphone, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        const Text(
                          'オンデバイスAIのステータス',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildAvailabilityStatus(colorScheme),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _isChecking ? null : _checkAvailability,
                      icon: _isChecking
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.refresh, size: 18),
                      label: Text(_isChecking ? '確認中...' : '再確認'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'アプリ情報',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.info_outline, color: colorScheme.onSurfaceVariant),
                    title: const Text('バージョン'),
                    trailing: Text(
                      '1.2.0',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined, color: colorScheme.onSurfaceVariant),
                    title: const Text('プライバシーポリシー'),
                    trailing: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('準備中です')),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.description_outlined, color: colorScheme.onSurfaceVariant),
                    title: const Text('ライセンス'),
                    trailing: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                    onTap: () {
                      showLicensePage(
                        context: context,
                        applicationName: 'AnkiCards',
                        applicationVersion: '1.2.0',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityStatus(ColorScheme colorScheme) {
    if (_isChecking && _availability == null) {
      return const Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text('確認中...'),
        ],
      );
    }

    if (_availability == null) {
      return const Text('未確認');
    }

    if (_availability!.isAvailable) {
      return Row(
        children: [
          Icon(Icons.check_circle, color: colorScheme.primary, size: 18),
          const SizedBox(width: 6),
          Text(
            '利用可能 (iOS ${_availability!.osVersion})',
            style: TextStyle(color: colorScheme.primary),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cancel, color: colorScheme.error, size: 18),
              const SizedBox(width: 6),
              Text(
                '利用不可',
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ),
          if (_availability!.errorMessage != null) ...[
            const SizedBox(height: 4),
            Text(
              _availability!.errorMessage!,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      );
    }
  }
}
