<template>
  <div>
    <k-form-build ref="kfb" v-if="tempData" :value="tempData" />
  </div>
</template>
<script>
export default {
  props: {
    tempData: Object,
  },
  data() {
    return {
      jsonData: {
        list: [
          {
            type: "input",
            label: "单行文本",
            options: {
              width: "100%",
              defaultValue: "",
              placeholder: "请输入",
              disabled: false,
            },
            model: "input_1577875678405",
            key: "input_1577875678405",
            rules: [{ required: true, message: "必填项" }],
          },
          {
            type: "date",
            label: "日期选择器",
            options: {
              width: "100%",
              defaultValue: "",
              range: false,
              showTime: false,
              disabled: false,
              clearable: false,
              placeholder: "请选择",
              rangePlaceholder: ["开始时间", "结束时间"],
              format: "YYYY-MM-DD",
            },
            model: "date_1577877450971",
            key: "date_1577877450971",
            rules: [{ required: true, message: "必填项" }],
          },
          {
            type: "textarea",
            label: "多行文本",
            options: {
              width: "100%",
              minRows: 4,
              maxRows: 6,
              defaultValue: "",
              disabled: false,
              placeholder: "请输入",
            },
            model: "textarea_1577877446659",
            key: "textarea_1577877446659",
            rules: [{ required: true, message: "必填项" }],
          },
          {
            type: "rate",
            label: "评分",
            options: {
              defaultValue: 0,
              max: 5,
              disabled: false,
              allowHalf: false,
            },
            model: "rate_1577877468717",
            key: "rate_1577877468717",
            rules: [{ required: true, message: "必填项" }],
          },
        ],
        config: {
          layout: "horizontal",
          labelCol: { span: 4 },
          wrapperCol: { span: 18 },
          hideRequiredMark: false,
          customStyle: "",
        },
      },
    };
  },
  method: {
    getData() {
      // this.$refs.kfb.
    }
  }
};
</script>