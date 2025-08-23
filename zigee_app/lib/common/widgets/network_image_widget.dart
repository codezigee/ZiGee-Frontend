import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/common/widgets/custom_loading_indicator.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? fallbackImagePath;

  const NetworkImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackImagePath,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildErrorPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildLoadingPlaceholder(),
      errorWidget:
          (context, error, stackTrace) =>
              fallbackImagePath != null
                  ? _buildFallback(fallbackImagePath!)
                  : _buildErrorPlaceholder(),
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
    );
  }

  Widget _buildFallback(String imagePath) {
    return Image.asset(imagePath, width: width, height: height, fit: fit);
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: ColorTokens.backgroundTertiary,
      child: const Icon(
        Icons.image_not_supported_sharp,
        color: ColorTokens.textTertiary,
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: ColorTokens.backgroundTertiary,
      child: const CustomLoadingIndicator(),
    );
  }
}
