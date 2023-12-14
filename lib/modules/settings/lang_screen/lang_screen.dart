import 'package:bhagavat_geeta/app/constant/icon_constant.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

class LangScreen extends StatefulWidget {
  String lang;
  bool fromSetting;
  LangScreen({required this.lang, this.fromSetting = false, super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: widget.fromSetting
          ? AppBar(
              titleSpacing: 0,
              title: Text(
                "Select Language",
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              leading: IconButton(
                  onPressed: () {
                    context.navigationCubit.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              if (!widget.fromSetting)
                const SizedBox(
                  height: 44,
                ),
              if (!widget.fromSetting)
                Text(
                  'Select Audio Language',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist().copyWith(
                    color: const Color(0xFF343A3F),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              SizedBox(
                height: widget.fromSetting ? 16 : 40,
              ),
              SizedBox(
                height: 132,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.lang = "en";
                        if (widget.fromSetting) {
                          context
                              .read<MusicListCubit>()
                              .updateLanguage(widget.lang);
                          GetIt.instance
                              .get<BaseLocalStorage>()
                              .write("lang", widget.lang);
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 164,
                        height: 132,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 136,
                                child: Text(
                                  'English',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.urbanist().copyWith(
                                    color: const Color(0xFF343A3F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 14,
                              right: 14,
                              child: Image.asset(
                                widget.lang == "en"
                                    ? IconFile.checkedCheckbox
                                    : IconFile.emptyCheckbox,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.lang = "np";
                        if (widget.fromSetting) {
                          context
                              .read<MusicListCubit>()
                              .updateLanguage(widget.lang);
                          GetIt.instance
                              .get<BaseLocalStorage>()
                              .write("lang", widget.lang);
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 164,
                        height: 132,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 136,
                                child: Text(
                                  'Nepali',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.urbanist().copyWith(
                                    color: const Color(0xFF343A3F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 14,
                              right: 14,
                              child: Image.asset(
                                widget.lang == "np"
                                    ? IconFile.checkedCheckbox
                                    : IconFile.emptyCheckbox,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!widget.fromSetting)
                InkWell(
                  onTap: () async {
                    GetIt.instance
                        .get<BaseLocalStorage>()
                        .write("lang", widget.lang);
                    // ignore: use_build_context_synchronously
                    context.navigationCubit.push(AppPage(
                        page: MaterialPage(
                            child: MusicList(oldLang: widget.lang)),
                        path: ""));
                  },
                  child: SizedBox(
                    height: 44,
                    child: Center(
                      child: Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist().copyWith(
                          color: const Color(0xFF3F4553),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 34,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
