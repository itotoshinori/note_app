<template>
  <div class="form">
    <div class="box">
      <div class="form-group">
        <input
          v-model="post.searchWord"
          placeholder="検索ワード"
          class="input-primary"
        />
        <button @click="send" class="button_color_orange">検索</button>
        <button @click="reset" class="button_color_red">画面初期化</button>
      </div>
      <div>
        <input
          type="checkbox"
          name="complete"
          v-model="post.searchUncomplete"
          @change="send"
        />
        <label for="complete"
          ><span class="label_content">未完了&nbsp;</span></label
        >
        <input
          type="checkbox"
          name="complete"
          v-model="post.upImportant"
          @change="send"
        />
        <label for="complete"
          ><span class="label_content">重要順&nbsp;</span></label
        >
        <input
          type="checkbox"
          name="updateAt"
          v-model="post.updateAt"
          @change="send"
        />
        <label for="complete"
          ><span class="label_content">更新降順&nbsp;</span></label
        >
        <input
          type="checkbox"
          name="twitter"
          v-model="post.searchTwitter"
          @change="send"
        />
        <label for="complete"
          ><span class="label_content">twitter&nbsp;</span></label
        >
        <input
          type="checkbox"
          name="link"
          v-model="post.searchLink"
          @change="send"
        />
        <label for="complete"
          ><span class="label_content">リンク&nbsp;</span></label
        >
      </div>
    </div>
  </div>
</template>
<script>
import utilsMixin from "utilities";
export default {
  mixins: [utilsMixin],
  data: function () {
    return {
      post: {
        searchWord: "",
        searchUncomplete: "",
        upImportant: "",
        updateAt: "",
        searchTwitter: "",
        serchLink: "",
      },
    };
  },
  methods: {
    send: function () {
      this.$emit("panretMessage", this.post);
    },
    reset: function () {
      this.$emit("panretReset");
    },
  },
};
</script>
<style lang="scss" scoped>
.form {
  background-color: #f4fffc;
  padding-top: 10px;
}
.form-group {
  margin-bottom: 4px;
}
.box {
  padding: 0.5em 0;
  width: 37%;
  margin: auto;
}
.textarea-primary {
  display: inline-block;
  vertical-align: top;
  width: 100%;
  max-height: 170px;
  padding-left: 2px;
  box-sizing: border-box;
  border-radius: 5px;
  border: 1px solid #e5e5e5;
  font-size: 18px;
  outline: none;
  line-height: 1.6;
  resize: vertical;
}
.input-primary {
  display: inline-block;
  vertical-align: top;
  width: 40%;
  height: 30px;
  padding-left: 2px;
  box-sizing: border-box;
  border-radius: 5px;
  border: 1px solid #e5e5e5;
  font-size: 18px;
  outline: none;
  line-height: 1.6;
}
@media (max-width: 1020px) and (min-width: 768px) {
  .box {
    padding: 0.5em 1em;
    margin: 2em 0;
    width: 90%;
    margin: auto;
  }
}
button {
  width: 100px;
}
.button_color_orange {
  background: orange;
  color: white;
}
.button_color_red {
  background: rebeccapurple;
  color: white;
}
</style>
