import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              Color(0xffC84B6A),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: .25),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [

            //----------------------------------------
            // Background Decoration
            //----------------------------------------

            Positioned(
              right: -40,
              top: -30,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              right: 40,
              bottom: 25,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            //----------------------------------------
            // Content
            //----------------------------------------

            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: .18,
                            ),
                            borderRadius:
                            BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "✨ PREMIUM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "Unlimited\nReading",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 34,
                            height: 1,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Unlock premium books,\naudiobooks and exclusive collections.",
                          style: TextStyle(
                            color: Colors.white
                                .withValues(alpha: .92),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          height: 44,
                          child: FilledButton.icon(
                            style:
                            FilledButton.styleFrom(
                              backgroundColor:
                              Colors.white,
                              foregroundColor:
                              AppColors.primary,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                  30,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.workspace_premium,
                              size: 18,
                            ),
                            label: const Text(
                              "Explore",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 82,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}