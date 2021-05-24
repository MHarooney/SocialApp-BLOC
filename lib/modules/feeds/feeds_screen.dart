import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocially/shared/cubit/cubit.dart';
import 'package:mysocially/shared/cubit/states.dart';
import 'package:mysocially/styles/colors.dart';
import 'package:mysocially/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
          controller: cubit.scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://image.freepik.com/free-psd/eid-al-fitr-horizontal-banner-template_23-2148932011.jpg',
                      ),
                      fit: BoxFit.cover,
                      height: responsive.height * 0.24,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: 10,
              ),
              // SizedBox(
              //   height: 8.0,
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPostItem(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      // radius: responsive.height * 0.025,
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/51885062?v=4',
                        // '${AppCubit.get(context).userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mahmoud Al-Haroon',
                                // '${AppCubit.get(context).userModel.name}',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 16.0,
                              ),
                            ],
                          ),
                          Text(
                            'January 21, 2021 at 11:00 pm',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  height: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 25.0,
                            child: MaterialButton(
                              height: 25.0,
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text(
                                '#software',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: defaultColor,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.freepik.com/free-psd/eid-al-fitr-horizontal-banner-template_23-2148932011.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '120',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Chat,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '120 comments',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              // radius: responsive.height * 0.025,
                              radius: 18.0,
                              backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/51885062?v=4',
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'write a comment ...',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      );
}