import 'package:flutter/material.dart';
import 'package:leo_inspector/Model/company_model.dart';

import '../../../../Services2/size_config.dart';
import '../../../../data/constants.dart';


class SelectTypeDialog extends StatefulWidget {

  final Function(QuestionOption) ok;
  final List<QuestionOption>? content;
  final QuestionOption? initVal;

  // ignore: use_key_in_widget_constructors
  const SelectTypeDialog({
    required this.ok,required this.content,this.initVal
  });

  @override
  State<SelectTypeDialog> createState() => _SelectTypeDialogState();
}

class _SelectTypeDialogState extends State<SelectTypeDialog> {

  late QuestionOption value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = QuestionOption();
    if(widget.initVal != null){
      value = widget.initVal!;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(height: SizeConfig.blockSizeHorizontal*5,),

              const Text(
                'Select',
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 17,
                    fontFamily: Constants.fontRegular
                ),
              ),

              SizedBox(height: SizeConfig.blockSizeHorizontal*5,),

              Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey[200],
              ),

              SizedBox(height: SizeConfig.blockSizeHorizontal*2,),

              ListView.builder(
                  itemCount: widget.content!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return SelectTile(
                        title: widget.content![index].equipmentType!,
                        isSelected: (value ==  widget.content![index]),
                        onSelected: (){
                          setState(() {
                            value =  widget.content![index];
                          });
                          widget.ok(value);
                          Navigator.pop(context,true);
                        }
                    );
                  }
              ),

              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectTile extends StatelessWidget {

  final Function() onSelected;
  final bool isSelected;
  final String title;

  const SelectTile({Key? key,required this.title,required this.isSelected,required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        onSelected();
      },
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.blockSizeHorizontal*12,
        child: Row(
          children: [

            const SizedBox(width: 5,),

            Container(
              alignment: Alignment.center,
              height: SizeConfig.blockSizeHorizontal*12,
              width: SizeConfig.blockSizeHorizontal*12,
              child: Icon(
                (isSelected) ? Icons.radio_button_checked : Icons.radio_button_off,
                color: (isSelected) ? Constants.primaryColor : Colors.grey,
                size: 17,
              ),
            ),

            const SizedBox(width: 5,),

            Expanded(
              child: Text(title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                    color: (isSelected) ? Constants.primaryColor : Colors.black,
                    fontSize: 17,
                    fontFamily: Constants.fontRegular
                ),),
            )

          ],
        ),
      ),
    );
  }
}

