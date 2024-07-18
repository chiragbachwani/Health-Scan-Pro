import 'package:healthscanpro/views/alzheimer_screen/alzheimer_screen.dart';

import '../../const/const.dart';
import '../../const/lists.dart';
import '../../controller/product_controller.dart';
import '../../widgets_common/bg_widget.dart';

class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DiagnosisController());

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        title: 'Diagnosis'.text.bold.white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200),
          itemBuilder: (context, index) {
            return Column(
              children: [
                10.heightBox,
                Image.network(categoryImages[index],
                    height: 140, width: 170, fit: BoxFit.cover),
                10.heightBox,
                categoryList[index]
                    .text
                    .semiBold
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make()
              ],
            )
                .box
                .white
                .roundedSM
                .clip(Clip.antiAlias)
                .outerShadowMd
                .make()
                .onTap(() {
              // Get.to(() => AlzheimerScreen());
              // controller.getSubCategories(categoryList[index]);
              // Get.to(() => CategoryDetails(title: categoryList[index]));
            });
          },
        ),
      ),
    ));
  }
}
