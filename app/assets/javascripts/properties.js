
const updateFormProperty = (event) => {
  let parentNode = event.target.data.parentNode
  let formPropertyId = event.target.data.formPropertyId

  let name = parentNode.querySelector('.form-property-name-on').value
  let description = parentNode.querySelector('.form-property-description-on').value
  let data = { 'form_property': {
    'id': formPropertyId,
    'name': name,
    'description': description
  } }
  ajaxUpdate(data, successCallback, errorCallback, [parentNode, data])
}

const ajaxUpdate = (data, successCallback, errorCallback, callbackArgs) => {
  const url = `/form_properties/${data['form_property']['id']}/ajax`
  const request = new XMLHttpRequest()
  request.open('PUT', url, true)
  request.setRequestHeader('Content-Type', 'application/json')
  request.onload = function () {
    if (request.status >= 200 && request.status < 400) {
      successCallback(callbackArgs)
    } else {
      errorCallback(callbackArgs)
    }
  }

  request.send(JSON.stringify(data))
}

const successCallback = (args) => {
  let parentNode = args[0]
  let data = args[1]

  parentNode.querySelector('.form-property-name-off').textContent = data['form_property']['name']
  parentNode.querySelector('.form-property-description-off').textContent = data['form_property']['description']

  toggleEditMode(parentNode, 'off')

  cleanUp(parentNode)
}

const errorCallback = (args) => {
  let parentNode = args[0]

  toggleEditMode(parentNode, 'off')

  cleanUp(parentNode)
}

const cancelEdit = (event) => {
  let parentNode = event.target.data.parentNode
  parentNode.querySelectorAll('.edit-form-property-off').forEach((elem) => {
    elem.style.display = 'block'
  })
  parentNode.querySelectorAll('.edit-form-property-on').forEach((elem) => {
    elem.style.display = 'none'
  })

  cleanUp(parentNode)
}

const cleanUp = (parentNode) => {
  let cancelButton = parentNode.querySelector('.cancel-form-property')
  cancelButton.removeEventListener('click', cancelEdit, false)

  let updateButton = parentNode.querySelector('.update-form-property')
  updateButton.removeEventListener('click', updateFormProperty, false)
}

const toggleEditMode = (parentNode, mode) => {
  if (mode === 'on') {
    parentNode.querySelectorAll('.edit-form-property-off').forEach((elem) => {
      elem.style.display = 'none'
    })
    parentNode.querySelectorAll('.edit-form-property-on').forEach((elem) => {
      elem.style.display = 'block'
    })
  } else if (mode === 'off') {
    parentNode.querySelectorAll('.edit-form-property-off').forEach((elem) => {
      elem.style.display = 'block'
    })
    parentNode.querySelectorAll('.edit-form-property-on').forEach((elem) => {
      elem.style.display = 'none'
    })
  }
}

const attachEdition = (event) => {
  let elem = event.target
  let formPropertyId = elem.dataset['formPropertyId']
  let parentNode = document.querySelector('#form_property_' + formPropertyId)

  toggleEditMode(parentNode, 'on')

  parentNode.querySelector('.form-property-name-on').focus()

  // Cancel
  let cancelButton = parentNode.querySelector('.cancel-form-property')
  cancelButton.addEventListener('click', cancelEdit, false)
  cancelButton.data = {
    parentNode: parentNode
  }
  // Update
  let updateButton = parentNode.querySelector('.update-form-property')
  updateButton.addEventListener('click', updateFormProperty, false)
  updateButton.data = {
    parentNode: parentNode,
    formPropertyId: formPropertyId
  }
}

window.onload = () => {
  document.querySelectorAll('.edit-form-property').forEach((elem) => {
    elem.addEventListener('click', attachEdition)
  })
}
