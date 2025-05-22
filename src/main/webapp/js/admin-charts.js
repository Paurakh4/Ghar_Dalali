// Ghar Dalali - Admin Dashboard Charts

document.addEventListener('DOMContentLoaded', function () {
    // Add chart containers to the dashboard overview panel
    const dashboardPanel = document.getElementById('dashboard');
    if (dashboardPanel) {
        // Add chart grid after stats grid
        const statsGrid = dashboardPanel.querySelector('.stats-grid');
        const recentActivity = dashboardPanel.querySelector('.recent-activity');

        const chartGridHTML = `
            <div class="chart-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">User Growth</h3>
                        <div class="chart-actions">
                            <select id="userGrowthPeriod">
                                <option value="week">Last Week</option>
                                <option value="month" selected>Last Month</option>
                                <option value="year">Last Year</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-wrapper">
                        <canvas id="userGrowthChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Revenue</h3>
                        <div class="chart-actions">
                            <select id="revenuePeriod">
                                <option value="week">Last Week</option>
                                <option value="month" selected>Last Month</option>
                                <option value="year">Last Year</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-wrapper">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        `;

        // Insert chart grid before recent activity
        const chartGridContainer = document.createElement('div');
        chartGridContainer.innerHTML = chartGridHTML;
        dashboardPanel.insertBefore(chartGridContainer, recentActivity);

        // Initialize charts
        initUserGrowthChart();
        initRevenueChart();

        // Add event listeners for period selectors
        document.getElementById('userGrowthPeriod').addEventListener('change', function () {
            initUserGrowthChart(this.value);
        });

        document.getElementById('revenuePeriod').addEventListener('change', function () {
            initRevenueChart(this.value);
        });
    }
});

// User Growth Chart
function initUserGrowthChart(period = 'month') {
    const ctx = document.getElementById('userGrowthChart');
    if (!ctx) return;

    // Sample data
    let labels, data;

    if (period === 'week') {
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        data = [5, 8, 12, 7, 10, 15, 9];
    } else if (period === 'month') {
        labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
        data = [42, 55, 48, 60];
    } else {
        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        data = [120, 150, 180, 210, 240, 270, 310, 350, 390, 420, 480, 520];
    }

    // Destroy existing chart if it exists
    if (window.userGrowthChart) {
        window.userGrowthChart.destroy();
    }

    // Create new chart
    window.userGrowthChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'New Users',
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
                    cornerRadius: 8
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
                    }
                }
            }
        }
    });
}

// Revenue Chart
function initRevenueChart(period = 'month') {
    const ctx = document.getElementById('revenueChart');
    if (!ctx) return;

    // Sample data
    let labels, data;

    if (period === 'week') {
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        data = [5000, 7500, 12000, 8500, 11000, 15000, 9500];
    } else if (period === 'month') {
        labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
        data = [32000, 45000, 38000, 50000];
    } else {
        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        data = [95000, 120000, 110000, 135000, 150000, 170000, 190000, 210000, 230000, 250000, 280000, 310000];
    }

    // Destroy existing chart if it exists
    if (window.revenueChart) {
        window.revenueChart.destroy();
    }

    // Create new chart
    window.revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Revenue ($)',
                data: data,
                backgroundColor: '#34d399',
                borderRadius: 6,
                barThickness: 'flex',
                maxBarThickness: 35
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
                        label: function (context) {
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
                        callback: function (value) {
                            return '$' + value.toLocaleString();
                        }
                    }
                }
            }
        }
    });
}


