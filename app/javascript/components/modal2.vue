<template>
  <div>
    <div @click.self="$emit('close')" class="modal show" tabindex="-1">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              Modal Title
            </h5>
            <a @click="$emit('close')" class="close">
              <span aria-hidden="true">&times;</span>
            </a>
          </div>
          <div class="modal-body">
            test
          </div>
          <div class="modal-footer">
            <a @click="$emit('close')" class="btn btn-secondary" tabindex="">Close</a>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop fade show" />
  </div>
</template>

<style scoped>
  .modal{
    display: block;
  }
</style>