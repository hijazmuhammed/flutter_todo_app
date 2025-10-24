import 'package:flutter/material.dart';
import '../custom_button.dart';
import '../custom_modal.dart';

/// Example page demonstrating CustomButton and CustomModal usage
/// This is for reference only - can be deleted after understanding usage
class ComponentExamplesPage extends StatefulWidget {
  const ComponentExamplesPage({super.key});

  @override
  State<ComponentExamplesPage> createState() => _ComponentExamplesPageState();
}

class _ComponentExamplesPageState extends State<ComponentExamplesPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // BUTTON EXAMPLES
            const Text(
              'CustomButton Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Size variants
            const Text('Sizes:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Small Button',
              size: ButtonSize.small,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Medium Button',
              size: ButtonSize.medium,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Large Button',
              size: ButtonSize.large,
              onPressed: () {},
            ),
            
            const SizedBox(height: 20),
            const Text('Variants:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Primary',
              variant: ButtonVariant.primary,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Success',
              variant: ButtonVariant.success,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Error',
              variant: ButtonVariant.error,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Warning',
              variant: ButtonVariant.warning,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Info',
              variant: ButtonVariant.info,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Secondary',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Outline',
              variant: ButtonVariant.outline,
              onPressed: () {},
            ),
            
            const SizedBox(height: 20),
            const Text('With Icons:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Add Item',
              icon: Icons.add,
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Next',
              icon: Icons.arrow_forward,
              iconRight: true,
              onPressed: () {},
            ),
            
            const SizedBox(height: 20),
            const Text('Loading State:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Loading...',
              isLoading: _isLoading,
              onPressed: _simulateLoading,
            ),
            
            const SizedBox(height: 20),
            const Text('Full Width:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Full Width Button',
              isFullWidth: true,
              size: ButtonSize.large,
              onPressed: () {},
            ),
            
            const SizedBox(height: 40),
            
            // MODAL EXAMPLES
            const Text(
              'CustomModal Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            CustomButton(
              text: 'Success Modal (Center)',
              variant: ButtonVariant.success,
              isFullWidth: true,
              onPressed: _showSuccessModal,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Error Modal (Bottom)',
              variant: ButtonVariant.error,
              isFullWidth: true,
              onPressed: _showErrorModal,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Warning Modal',
              variant: ButtonVariant.warning,
              isFullWidth: true,
              onPressed: _showWarningModal,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Info Modal',
              variant: ButtonVariant.info,
              isFullWidth: true,
              onPressed: _showInfoModal,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Confirmation Modal',
              variant: ButtonVariant.secondary,
              isFullWidth: true,
              onPressed: _showConfirmationModal,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Large Modal',
              variant: ButtonVariant.outline,
              isFullWidth: true,
              onPressed: _showLargeModal,
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  void _showSuccessModal() {
    CustomModal.show(
      context: context,
      position: ModalPosition.center,
      title: 'Success!',
      message: 'Your operation completed successfully.',
      type: ModalType.success,
      size: ModalSize.small,
      primaryButtonText: 'Great',
      onPrimaryPressed: () {
        print('Success confirmed');
      },
    );
  }

  void _showErrorModal() {
    CustomModal.show(
      context: context,
      position: ModalPosition.bottom,
      title: 'Error Occurred',
      message: 'Something went wrong. Please try again.',
      type: ModalType.error,
      primaryButtonText: 'Retry',
      secondaryButtonText: 'Cancel',
      onPrimaryPressed: () {
        print('Retrying...');
      },
    );
  }

  void _showWarningModal() {
    CustomModal.show(
      context: context,
      title: 'Warning',
      message: 'This action cannot be undone. Are you sure you want to proceed?',
      type: ModalType.warning,
      primaryButtonText: 'Proceed',
      secondaryButtonText: 'Cancel',
      onPrimaryPressed: () {
        print('Proceeding with action');
      },
    );
  }

  void _showInfoModal() {
    CustomModal.show(
      context: context,
      position: ModalPosition.bottom,
      title: 'Information',
      message: 'This is some important information you should know about.',
      type: ModalType.info,
      primaryButtonText: 'Got it',
    );
  }

  void _showConfirmationModal() {
    CustomModal.show(
      context: context,
      title: 'Confirm Action',
      message: 'Do you want to save these changes?',
      type: ModalType.neutral,
      primaryButtonText: 'Yes',
      secondaryButtonText: 'No',
      onPrimaryPressed: () {
        print('Changes saved');
      },
      onSecondaryPressed: () {
        print('Changes discarded');
      },
    );
  }

  void _showLargeModal() {
    CustomModal.show(
      context: context,
      title: 'Large Content Modal',
      message: 'This modal has more space for content.',
      type: ModalType.info,
      size: ModalSize.large,
      customContent: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Custom content can go here'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter something',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      primaryButtonText: 'Submit',
      secondaryButtonText: 'Cancel',
    );
  }
}

