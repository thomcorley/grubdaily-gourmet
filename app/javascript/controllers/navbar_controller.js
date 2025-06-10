import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["burger", "menu", "openMenu", "closeMenu"]

    connect() {
        // Initialize the navbar state
        this.isMenuOpen = false

        // Bind methods to preserve 'this' context
        this.handleWindowResize = this.handleWindowResize.bind(this)
        this.setMenuHeight = this.setMenuHeight.bind(this)

        // Set initial menu height
        this.setMenuHeight()

        // Set up event listeners
        this.setupEventListeners()
    }

    disconnect() {
        // Clean up event listeners when controller is disconnected
        window.removeEventListener("resize", this.handleWindowResize)
        document.removeEventListener("turbo:load", this.setMenuHeight)
    }

    setupEventListeners() {
        // Handle window resize
        window.addEventListener("resize", this.handleWindowResize)

        // Handle Turbo page loads
        document.addEventListener("turbo:load", this.setMenuHeight)
    }

    toggle() {
        this.isMenuOpen = !this.isMenuOpen

        // Toggle icon visibility
        this.openMenuTarget.classList.toggle("is-hidden")
        this.closeMenuTarget.classList.toggle("is-hidden")

        // Toggle burger and menu active states
        this.burgerTarget.classList.toggle("is-active")
        this.menuTarget.classList.toggle("is-active")

        // Set menu height when opening on mobile
        if (this.isMenuOpen && this.isMobile()) {
            this.setMenuHeight()
        }
    }

    handleWindowResize() {
        if (this.isMobile()) {
            this.setMenuHeight()
        } else {
            // Reset menu styles on desktop
            this.menuTarget.style.height = null
            // Close menu if it's open and we're now on desktop
            if (this.isMenuOpen) {
                this.closeMenu()
            }
        }
    }

    setMenuHeight() {
        if (this.isMobile()) {
            // Look for main container or fallback to viewport height
            const mainContainer = document.getElementById("main-container") ||
                document.querySelector(".main-body-container") ||
                document.body

            const containerHeight = mainContainer.clientHeight
            const viewportHeight = window.innerHeight

            // Use the larger of container height or viewport height, with some padding
            const menuHeight = Math.max(containerHeight, viewportHeight) + 50
            this.menuTarget.style.height = `${menuHeight}px`
        }
    }

    closeMenu() {
        if (this.isMenuOpen) {
            this.isMenuOpen = false

            // Reset icon visibility
            this.openMenuTarget.classList.remove("is-hidden")
            this.closeMenuTarget.classList.add("is-hidden")

            // Remove active states
            this.burgerTarget.classList.remove("is-active")
            this.menuTarget.classList.remove("is-active")
        }
    }

    // Helper method to check if we're in mobile view
    isMobile() {
        return document.body.clientWidth < 1024
    }

    // Method for subscribe form interaction (if still needed)
    goToSubscribeForm() {
        this.closeMenu()
    }
} 