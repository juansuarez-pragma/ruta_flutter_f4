import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/tokens.dart';
import '../../utils/extensions/extensions.dart';

/// Campo de texto del sistema de diseño.
///
/// Proporciona un input de texto con estilos consistentes y soporte para
/// validación, íconos y estados.
///
/// ## Uso básico
///
/// ```dart
/// DSTextField(
///   label: 'Email',
///   hint: 'ejemplo@correo.com',
///   onChanged: (value) => updateEmail(value),
/// )
/// ```
///
/// ## Con validación
///
/// ```dart
/// DSTextField(
///   label: 'Contraseña',
///   obscureText: true,
///   errorText: passwordError,
///   onChanged: (value) => updatePassword(value),
/// )
/// ```
class DSTextField extends StatelessWidget {
  /// Etiqueta del campo.
  final String? label;

  /// Texto de sugerencia.
  final String? hint;

  /// Texto de error.
  ///
  /// Si se proporciona, el campo se mostrará en estado de error.
  final String? errorText;

  /// Texto de ayuda.
  final String? helperText;

  /// Controlador del campo.
  final TextEditingController? controller;

  /// Callback cuando el texto cambia.
  final ValueChanged<String>? onChanged;

  /// Callback cuando se envía el campo.
  final ValueChanged<String>? onSubmitted;

  /// Si el texto debe estar oculto (para contraseñas).
  final bool obscureText;

  /// Tipo de teclado.
  final TextInputType? keyboardType;

  /// Ícono al inicio del campo.
  final IconData? prefixIcon;

  /// Ícono al final del campo.
  final IconData? suffixIcon;

  /// Callback cuando se presiona el ícono del final.
  final VoidCallback? onSuffixIconTap;

  /// Si el campo está habilitado.
  final bool enabled;

  /// Si el campo es de solo lectura.
  final bool readOnly;

  /// Si el campo permite múltiples líneas.
  final int? maxLines;

  /// Número mínimo de líneas.
  final int? minLines;

  /// Longitud máxima del texto.
  final int? maxLength;

  /// Si debe autoenfocarse.
  final bool autofocus;

  /// Acción del teclado.
  final TextInputAction? textInputAction;

  /// Formateadores de entrada.
  final List<TextInputFormatter>? inputFormatters;

  /// Focus node.
  final FocusNode? focusNode;

  const DSTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.textInputAction,
    this.inputFormatters,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: tokens.typographyLabelMedium.copyWith(
              color: hasError
                  ? tokens.colorFeedbackError
                  : tokens.colorTextPrimary,
            ),
          ),
          const SizedBox(height: DSSpacing.sm),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autofocus: autofocus,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          style: tokens.typographyBodyMedium.copyWith(
            color: enabled ? tokens.inputText : tokens.colorTextDisabled,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: tokens.typographyBodyMedium.copyWith(
              color: tokens.inputPlaceholder,
            ),
            errorText: hasError ? errorText : null,
            helperText: helperText,
            helperStyle: tokens.typographyCaption,
            filled: true,
            fillColor: enabled ? tokens.inputBackground : tokens.colorSurfaceSecondary,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: hasError
                        ? tokens.colorFeedbackError
                        : tokens.colorIconSecondary,
                    size: DSSizes.iconMd,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: Icon(
                      suffixIcon,
                      color: hasError
                          ? tokens.colorFeedbackError
                          : tokens.colorIconSecondary,
                      size: DSSizes.iconMd,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.base,
              vertical: DSSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(color: tokens.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(
                color: hasError ? tokens.inputBorderError : tokens.inputBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(
                color: hasError
                    ? tokens.inputBorderError
                    : tokens.inputBorderFocused,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(color: tokens.inputBorderError),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(color: tokens.inputBorderError, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
              borderSide: BorderSide(color: tokens.colorBorderSecondary),
            ),
          ),
        ),
      ],
    );
  }
}
