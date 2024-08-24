import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/globals/app_assets.dart';
import 'package:my_portfolio/helper%20class/helper_class.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  final onH0verEffect = Matrix4.identity()..scale(1.0);

  List images = <String>[
    AppAssets.Calculator,
    AppAssets.Realestate,
    AppAssets.Clinikx,
    AppAssets.Clinikx1,
    AppAssets.Makemypropertyz,
    AppAssets.Makemypropertyz1,
  ];

  List<String> projectTitles = [
    'Calculator App',
    'Cafe Ordering App',
    'Clinikx Doctor App',
    'Clinikx Patient',
    'MakeMy Propertyz App',
    'MakeMy Propertyz Web',
  ];

  List<String> projectDescriptions = [
    'The Calculator App, created with Flutter, offers both basic and advanced scientific functions in a user-friendly interface. It\'s perfect for everyday calculations and complex math needs.',
    'The Cafe Ordering App, built with Flutter, allows users to browse the menu, customize, and place orders seamlessly.',
    'Clinic admins handle doctor profiles, appointment scheduling, and patient interactions, while doctors manage their schedules, update patient statuses, and add notes.',
    'Patients use QR codes for registration, receive token numbers, and manage appointments',
    'An intuitive real estate app that streamlines property listings and transactions. Offers a seamless experience for buying, selling, and managing properties with user-friendly features.',
    'A real estate management app for listing, buying, and selling properties efficiently.',
  ];

  List<String> projectLinks = [
    'https://github.com/JanardhanGowda18/Calculator_App',
    'https://github.com/JanardhanGowda18/Cafe_screens',
    'https://clinikx-doctor.netlify.app',
    'https://clinikxpatientform.netlify.app/',
    'https://66b074f07275d7915b9783f4--grand-starlight-5e957b.netlify.app/',
    'https://makemypropertyz.netlify.app/',
  ];

  var hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 1)
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 2)
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 3),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgColor2,
    );
  }

  GridView buildProjectGridView({required int crossAxisCount}) {
    return GridView.builder(
      itemCount: images.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 280,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        var image = images[index];
        return FadeInUpBig(
          duration: const Duration(milliseconds: 1600),
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                hoveredIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                hoveredIndex = null;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => _launchURL(projectLinks[index]), // Open project link on tap
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
                Visibility(
                  visible: index == hoveredIndex,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    transform: index == hoveredIndex ? onH0verEffect : null,
                    curve: Curves.easeIn,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            AppColors.themeColor.withOpacity(1.0),
                            AppColors.themeColor.withOpacity(0.9),
                            AppColors.themeColor.withOpacity(0.8),
                            AppColors.themeColor.withOpacity(0.6),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                    child: Column(
                      children: [
                        Text(
                          projectTitles[index],
                          style: AppTextStyles.montserratStyle(
                              color: Colors.black87, fontSize: 15),
                        ),
                        // Constants.sizedBox(height: 10.0),
                        Text(
                          projectDescriptions[index],
                          style: AppTextStyles.normalStyle(
                              color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        Constants.sizedBox(height: 10.0),
                        TextButton(
                          onPressed: () => _launchURL(projectLinks[index]), // Open project link on button press
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.bgColor,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'More Info',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
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
      },
    );
  }

  FadeInDown buildProjectText() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: RichText(
        text: TextSpan(
          text: 'Latest ',
          style: AppTextStyles.headingStyles(fontSize: 30.0),
          children: [
            TextSpan(
              text: 'Projects',
              style: AppTextStyles.headingStyles(
                  fontSize: 30, color: AppColors.robinEdgeBlue),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication); // Updated to use external browser
      } else {
        print('Could not launch $url'); // Debugging output
      }
    } catch (e) {
      print('Error launching $url: $e'); // Catch and print any errors
    }
  }

}
