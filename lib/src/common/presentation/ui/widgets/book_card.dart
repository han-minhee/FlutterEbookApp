import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_ebook_app/src/features/features.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class BookCard extends ConsumerWidget {
  final String img;
  final Entry entry;

  BookCard({
    super.key,
    required this.img,
    required this.entry,
  });

  static const uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 120.0,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        elevation: 4.0,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          onTap: () {
            final bool isHomeTab =
                ref.read(currentTabNotifierProvider).isHomeTab;
            final route = BookDetailsRoute(
              entry: entry,
              imgTag: imgTag,
              titleTag: titleTag,
              authorTag: authorTag,
            );

            if (context.isLargeScreen && isHomeTab) {
              context.router.replace(route);
            } else {
              context.router.push(route);
            }
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: _CoverImage(image: img),
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  final String image;

  const _CoverImage({required this.image});

  bool get _isAsset => image.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (_isAsset) {
      return Image.asset(
        image,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => const LoadingWidget(
        isImage: true,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'packages/reader_widget/assets/images/cover.png',
        fit: BoxFit.cover,
      ),
      fit: BoxFit.cover,
    );
  }
}
