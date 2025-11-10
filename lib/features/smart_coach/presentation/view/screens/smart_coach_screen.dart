import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/chat_section.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/enum/sender.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../view_model/smart_coach_cubit.dart';
import '../../view_model/smart_coach_state.dart';
import '../widgets/chat.dart';
import '../widgets/smart_coach_profile.dart';
class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({super.key});

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}
late SmartCoachCubit cubit;
class _SmartCoachScreenState extends State<SmartCoachScreen> {
  final TextEditingController message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showPreviousChat = false;
  @override
  void initState() {
    super.initState();
    cubit = getIt.get<SmartCoachCubit>();
  }


  @override
  void dispose() {
    message.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    final text = message.text.trim();
    if (text.isEmpty) return;

    final SmartCoachCubit cubit = context.read<SmartCoachCubit>();
    if (cubit.state.isLoading==false) {
      cubit.sendMessage(text);
      message.clear();
    }
    cubit.fetchConversationSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SmartCoachCubit>()..startNewConversation(),
      child: Builder(
        builder: (_) => Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body:HomeBackground(image: AssetsManager.chatBg, alpha: 0.20, child:       Column(
                children: [
                   SizedBox(height: context.setHight(30),),
                   ChatSection(
                    onTap: (){
setState(() {
  _showPreviousChat = !_showPreviousChat;
});
                    },
                  ),
                  Expanded(
                    child: BlocConsumer<SmartCoachCubit,
                        SmartCoachChatState>(
                      listener: (context, state) {
                        if (state.errorMessage != null &&
                            state.errorMessage!.isNotEmpty) {}

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent +
                                  80,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn,
                            );
                          }
                        });
                      },
                      builder: (context, state) {
                        final messages = state.messages ??[];

                        return ListView.builder(
                          controller: _scrollController,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isSmartCoach = message.role == Sender.model;
                            final text = message.text;

                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: isSmartCoach
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  isSmartCoach?
                                    const SmartCoachProfile():const SizedBox.shrink(),
                                  if (!isSmartCoach) const
                                  SizedBox(width: 40),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: isSmartCoach
                                            ? AppColors.gray
                                            .withOpacity(0.07)
                                            : AppColors.orange
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft:
                                          const Radius.circular(20),
                                          bottomRight:
                                          const Radius.circular(20),
                                          topLeft: Radius.circular(
                                              isSmartCoach ? 0 : 20),
                                          topRight: Radius.circular(
                                              isSmartCoach ? 20 : 0),
                                        ),
                                      ),
                                      child: Text(
                                        text,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  if (!isSmartCoach)
                                    const UserProfile(),
                                  if (isSmartCoach) const SizedBox(width: 40),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SmartCoachCubit, SmartCoachChatState>(
                    builder: (context, state) {
                      final bool isLoading = state.isLoading;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  controller: message,
                                  style: const TextStyle(
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: context.loc.typeYourMessage,
                                    hintStyle: const TextStyle(
                                        color: Colors.white54),
                                    border: InputBorder.none,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  ),
                                  enabled: !isLoading,
                                  onFieldSubmitted: (_){
                                    _sendMessage(context);
                                  },

                                ),
                              ),
                            ),
                             SizedBox(width: context.setWidth(12)),
                            IconButton(
                              icon: isLoading
                                  ?  SizedBox(
                                width: context.setWidth(26),
                                height: context.setHight(26),
                                child:LoadingAnimationWidget.inkDrop(
                                    color: AppColors.orange[AppColors.baseColor]!,
                                    size: context.setMinSize(24)),
                              )
                                  : const Icon(Icons.send,
                                  color: Colors.white),
                              onPressed: isLoading==false? () {
                                _sendMessage(context);
                              }:
                                   null
                                  ,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ))
            ),
            AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              top: 0,
              bottom: 0,
              end:
              _showPreviousChat ? 0 : -MediaQuery.of(context).size.width
                  * 0.7,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: PreviousChatMenu(
                  onConversationSelected: (){
                    _showPreviousChat=false;
                    setState(() {

                    });
                  }),
                ),

            ),
          ],
        ),
      ),
    );
  }
}
