import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "selectedList", "searchContainer"]
  static values = {
    selected: { type: Array, default: [] },
    delay: { type: Number, default: 300 }
  }
  static classes = ["loading"]

  connect() {
    this.selectedOrganizations = Array.from(this.selectedListTarget.querySelectorAll('.selected-organization'))
      .map(el => ({
        id: el.dataset.organizationId,
        name: el.querySelector('span').textContent
      }))
    
    this.setupKeyboardNavigation()
  }

  setupKeyboardNavigation() {
    this.inputTarget.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    const results = this.resultsTarget.querySelectorAll('.organization-result')
    const currentIndex = Array.from(results).findIndex(el => el.classList.contains('highlighted'))

    switch(event.key) {
      case 'ArrowDown':
        event.preventDefault()
        this.highlightResult(results, currentIndex + 1)
        break
      case 'ArrowUp':
        event.preventDefault()
        this.highlightResult(results, currentIndex - 1)
        break
      case 'Enter':
        event.preventDefault()
        const highlighted = this.resultsTarget.querySelector('.organization-result.highlighted')
        if (highlighted) highlighted.click()
        break
      case 'Escape':
        event.preventDefault()
        this.clearResults()
        break
    }
  }

  highlightResult(results, index) {
    if (!results.length) return
    
    results.forEach(r => r.classList.remove('highlighted'))
    const newIndex = (index + results.length) % results.length
    results[newIndex].classList.add('highlighted')
    results[newIndex].scrollIntoView({ block: 'nearest' })
  }

  async search() {
    clearTimeout(this.timeout)
    const query = this.inputTarget.value.trim()
    
    if (query.length < 2) {
      this.clearResults()
      return
    }

    this.timeout = setTimeout(async () => {
      try {
        this.searchContainerTarget.classList.add(this.loadingClass)
        const response = await fetch(`/campaigns/search_organizations?query=${encodeURIComponent(query)}`, {
          headers: {
            "Accept": "text/html",
            "X-Requested-With": "XMLHttpRequest"
          }
        })

        if (!response.ok) throw new Error('Search failed')
        
        const html = await response.text()
        this.resultsTarget.innerHTML = html
      } catch (error) {
        console.error('Search error:', error)
        this.resultsTarget.innerHTML = '<div class="search-error">An error occurred while searching</div>'
      } finally {
        this.searchContainerTarget.classList.remove(this.loadingClass)
      }
    }, this.delayValue)
  }

  clearResults() {
    this.resultsTarget.innerHTML = ''
  }

  select(event) {
    event.preventDefault()
    const orgId = event.currentTarget.dataset.organizationId
    const orgName = event.currentTarget.dataset.organizationName

    if (!this.selectedOrganizations.some(org => org.id === orgId)) {
      this.selectedOrganizations.push({ id: orgId, name: orgName })
      this.updateSelectedOrganizations()
    }

    this.inputTarget.value = ""
    this.clearResults()
  }

  remove(event) {
    event.preventDefault()
    const orgId = event.currentTarget.dataset.organizationId
    this.selectedOrganizations = this.selectedOrganizations.filter(org => org.id !== orgId)
    this.updateSelectedOrganizations()
  }

  updateSelectedOrganizations() {
    const html = this.selectedOrganizations.map(org => `
      <div class="selected-organization" data-organization-id="${org.id}">
        <span>${org.name}</span>
        <input type="hidden" name="campaign[organization_ids][]" value="${org.id}">
        <button type="button" data-action="organization-selector#remove" data-organization-id="${org.id}">&times;</button>
      </div>
    `).join('')
    
    this.selectedListTarget.innerHTML = html
  }
} 