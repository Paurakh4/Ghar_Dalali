// Ghar Dalali - User Dashboard Charts

document.addEventListener('DOMContentLoaded', function() {
    // Add chart containers to the payments panel
    const paymentsPanel = document.getElementById('payments');
    if (paymentsPanel) {
        // Add payment summary chart after the table
        const paymentsTable = paymentsPanel.querySelector('.payments-table');
        
        const paymentChartHTML = `
            <div class="chart-container">
                <div class="chart-header">
                    <h3 class="chart-title">Payment Summary</h3>
                    <div class="chart-actions">
                        <select id="paymentPeriod">
                            <option value="6months" selected>Last 6 Months</option>
                            <option value="year">Last Year</option>
                        </select>
                    </div>
                </div>
                <div class="chart-wrapper">
                    <canvas id="paymentSummaryChart"></canvas>
                </div>
            </div>
        `;
        
        // Insert chart after payments table
        const chartContainer = document.createElement('div');
        chartContainer.innerHTML = paymentChartHTML;
        paymentsPanel.insertBefore(chartContainer, null);
        
        // Initialize payment summary chart
        initPaymentSummaryChart();
        
        // Add event listener for period selector
        document.getElementById('paymentPeriod').addEventListener('change', function() {
            initPaymentSummaryChart(this.value);
        });
    }
    
    // Add chart to applications panel
    const applicationsPanel = document.getElementById('applications');
    if (applicationsPanel) {
        // Add application status chart after the table
        const applicationsTable = applicationsPanel.querySelector('.applications-table');
        
        const applicationChartHTML = `
            <div class="chart-container">
                <div class="chart-header">
                    <h3 class="chart-title">Application Status</h3>
                </div>
                <div class="chart-wrapper" style="height: 250px;">
                    <canvas id="applicationStatusChart"></canvas>
                </div>
            </div>
        `;
        
        // Insert chart after applications table
        const chartContainer = document.createElement('div');
        chartContainer.innerHTML = applicationChartHTML;
        applicationsPanel.insertBefore(chartContainer, null);
        
        // Initialize application status chart
        initApplicationStatusChart();
    }
    
    // Add chart to reviews panel
    const reviewsPanel = document.getElementById('reviews');
    if (reviewsPanel) {
        // Add review ratings chart after the reviews list
        const reviewsList = reviewsPanel.querySelector('.reviews-list');
        
        const reviewChartHTML = `
            <div class="chart-container">
                <div class="chart-header">
                    <h3 class="chart-title">Your Ratings Distribution</h3>
                </div>
                <div class="chart-wrapper" style="height: 250px;">
                    <canvas id="reviewRatingsChart"></canvas>
                </div>
            </div>
        `;
        
        // Insert chart after reviews list
        const chartContainer = document.createElement('div');
        chartContainer.innerHTML = reviewChartHTML;
        reviewsPanel.insertBefore(chartContainer, null);
        
        // Initialize review ratings chart
        initReviewRatingsChart();
    }
});

// Payment Summary Chart
function initPaymentSummaryChart(period = '6months') {
    const ctx = document.getElementById('paymentSummaryChart');
    if (!ctx) return;
    
    // Sample data
    let labels, data;
    
    if (period === '6months') {
        labels = ['January', 'February', 'March', 'April', 'May', 'June'];
        data = [1200, 1500, 1800, 1200, 2500, 1800];
    } else {
        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        data = [1200, 1500, 1800, 1200, 2500, 1800, 2000, 2200, 1900, 2100, 2400, 2800];
    }
    
    // Destroy existing chart if it exists
    if (window.paymentSummaryChart) {
        window.paymentSummaryChart.destroy();
    }
    
    // Create new chart
    window.paymentSummaryChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Payment Amount ($)',
                data: data,
                borderColor: '#4f6df5',
                backgroundColor: 'rgba(79, 109, 245, 0.1)',
                borderWidth: 2,
                tension: 0.3,
                fill: true,
                pointBackgroundColor: '#4f6df5',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#262626',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    bodyFont: {
                        size: 14
                    },
                    padding: 12,
                    cornerRadius: 8,
                    callbacks: {
                        label: function(context) {
                            return '$' + context.raw.toLocaleString();
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        callback: function(value) {
                            return '$' + value.toLocaleString();
                        }
                    }
                }
            }
        }
    });
}

// Application Status Chart
function initApplicationStatusChart() {
    const ctx = document.getElementById('applicationStatusChart');
    if (!ctx) return;
    
    // Sample data
    const data = {
        labels: ['Approved', 'Pending', 'Rejected'],
        datasets: [{
            data: [40, 45, 15],
            backgroundColor: ['#34d399', '#fbbf24', '#f87171'],
            borderWidth: 0,
            borderRadius: 4,
            hoverOffset: 10
        }]
    };
    
    // Create chart
    window.applicationStatusChart = new Chart(ctx, {
        type: 'doughnut',
        data: data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '65%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 20,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                },
                tooltip: {
                    backgroundColor: '#262626',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    bodyFont: {
                        size: 14
                    },
                    padding: 12,
                    cornerRadius: 8,
                    callbacks: {
                        label: function(context) {
                            return context.label + ': ' + context.raw + '%';
                        }
                    }
                }
            }
        }
    });
}

// Review Ratings Chart
function initReviewRatingsChart() {
    const ctx = document.getElementById('reviewRatingsChart');
    if (!ctx) return;
    
    // Sample data based on the reviews in the HTML
    const data = {
        labels: ['5 Stars', '4 Stars', '3 Stars', '2 Stars', '1 Star'],
        datasets: [{
            label: 'Number of Reviews',
            data: [1, 1, 0, 0, 0],
            backgroundColor: ['#fbbf24', '#fbbf24', '#fbbf24', '#fbbf24', '#fbbf24'],
            borderRadius: 6,
            barThickness: 'flex',
            maxBarThickness: 35
        }]
    };
    
    // Create chart
    window.reviewRatingsChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#262626',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    bodyFont: {
                        size: 14
                    },
                    padding: 12,
                    cornerRadius: 8
                }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    max: 2 // Set max to 2 to make the chart more visible with few reviews
                },
                y: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}
