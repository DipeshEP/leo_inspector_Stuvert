import 'package:flutter/material.dart';
import 'package:leo_inspector/Model/company_model.dart';

import '../../../../Services2/size_config.dart';
import '../../../../data/constants.dart';
import 'select_type.dart';


class DropDownUIDialog extends StatefulWidget {

  final Function(DropdownOption) ok;
  final List<DropdownOption>? content;
  final DropdownOption? initVal;

  // ignore: use_key_in_widget_constructors
  const DropDownUIDialog({
    required this.ok,required this.content,this.initVal
  });

  @override
  State<DropDownUIDialog> createState() => _DropDownUIDialogState();
}

class _DropDownUIDialogState extends State<DropDownUIDialog> {

  late DropdownOption value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = DropdownOption();
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
                        title: widget.content![index].option!,
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


