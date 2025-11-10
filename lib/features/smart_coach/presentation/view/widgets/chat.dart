import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../view_model/smart_coach_cubit.dart';
import '../../view_model/smart_coach_state.dart';

class PreviousChatMenu extends StatefulWidget {
  const PreviousChatMenu({super.key, required this.onConversationSelected});

  final VoidCallback onConversationSelected;

  @override
  State<PreviousChatMenu> createState() => _PreviousChatMenuState();
}

class _PreviousChatMenuState extends State<PreviousChatMenu> {
  @override
  void initState() {
    super.initState();
    context.read<SmartCoachCubit>().fetchConversationSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.bgCategory.withValues(alpha: 0.9),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(context.setMinSize(24)),
            bottomStart: Radius.circular(context.setMinSize(24)),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: context.setHight(12),
            horizontal: context.setWidth(16),
          ),
          child: Column(
            children: [
              SizedBox(height: context.setHight(20)),
              InkWell(
                onTap: () {
                  widget.onConversationSelected();
                },
                child: Text(
                  context.loc.previousConversations,
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: context.setSp(17),
                  ),
                ),
              ),
              SizedBox(height: context.setHight(16)),
              BlocBuilder<SmartCoachCubit, SmartCoachChatState>(
                builder: (context, state) {
                  final chats = context
                      .watch<SmartCoachCubit>()
                      .conversationSummaries;
                  return state.stateStatus!.isLoading == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height
                                  * 0.35,
                            ),
                            LoadingAnimationWidget.inkDrop(
                              color: AppColors.orange[AppColors.baseColor]!,
                              size: context.setMinSize(30),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      icon: Icons.delete,
                                      foregroundColor:
                                          AppColors.orange[AppColors.baseColor],
                                      backgroundColor: Colors.transparent,
                                      label: context.loc.delete,
                                      onPressed: (con) async {
                                        con
                                            .read<SmartCoachCubit>()
                                            .deleteConversation(
                                              chats[index][Constants.id],

                                            );


                                      },
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<SmartCoachCubit>()
                                            .fetchMessagesByConversationId(
                                              chats[index][Constants.id],
                                            );
                                        widget.onConversationSelected();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: AppColors
                                            .orange[AppColors.baseColor],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        chats[index][Constants.fieldText],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: getBoldStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: AppColors.shearGray,
                                height: context.setHight(10),
                              );
                            },
                            itemCount: chats.length,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
