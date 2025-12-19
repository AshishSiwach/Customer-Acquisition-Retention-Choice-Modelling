------------------------------------------------------------------------------
  # 1. SETUP & LIBRARIES
  # ------------------------------------------------------------------------------

# Load necessary packages
ensure_library("readxl")      # For reading Excel files
ensure_library("psych")       # For descriptive statistics
ensure_library("tidyverse")   # For data manipulation (dplyr, ggplot2, etc.)
ensure_library("broom")       # For tidying regression model outputs

# Disable scientific notation for easier reading of p-values (e.g., 0.000 vs 1.2e-5)
options(scipen = 999) 


# ------------------------------------------------------------------------------
# 2. CUSTOMER ACQUISITION MODEL (Demand Side)
# ------------------------------------------------------------------------------
message("--- STARTING CUSTOMER ANALYSIS ---")

# Step 2.1: Load Data
# Note: A popup window will appear. Select 'Airbnb Case Customer Data.xlsx'
message("Please select the CUSTOMER data file...")
df_customer <- read_excel(file.choose())

# Step 2.2: Data Inspection
# Good practice to check column names and basic stats before modeling
print("Customer Data - Column Names:")
print(names(df_customer))
print("Customer Data - Summary Statistics:")
print(summary(df_customer))

# Step 2.3: Logistic Regression Model
# Goal: Predict 'Choice' (1 = Signed Up, 0 = Did Not)
# Note: We exclude column 1 (Observations/IDs) using [,-1] as IDs are not predictors
fit_customer <- glm(Choice ~ .,
                    family = binomial(link = 'logit'), 
                    data = df_customer[,-1])

# Step 2.4: Results Output
# 'tidy' converts the raw model into a clean data frame
# We round numeric values to 2 decimal places for readability
Customer_Estimates <- tidy(fit_customer) %>% 
  mutate(across(where(is.numeric), round, digits = 3))

# View the final results table
message("Opening Customer Model Results...")
View(Customer_Estimates)


# ------------------------------------------------------------------------------
# 3. HOST ACQUISITION MODEL (Supply Side)
# ------------------------------------------------------------------------------
message("--- STARTING HOST ANALYSIS ---")

# Step 3.1: Load Data
# Note: A popup window will appear. Select 'Airbnb Case Host Data.xlsx'
message("Please select the HOST data file...")
df_host <- read_excel(file.choose())

# Step 3.2: Data Inspection
print("Host Data - Column Names:")
print(names(df_host))
print("Host Data - Summary Statistics:")
print(summary(df_host))

# Step 3.3: Logistic Regression Model
# Goal: Predict 'Choice' (1 = Listed Property, 0 = Did Not)
# Again, exclude column 1 (Host IDs)
fit_host <- glm(Choice ~ .,
                family = binomial(link = 'logit'), 
                data = df_host[,-1])

# Step 3.4: Results Output
Host_Estimates <- tidy(fit_host) %>% 
  mutate(across(where(is.numeric), round, digits = 3))

# View the final results table
message("Opening Host Model Results...")
View(Host_Estimates)

message("--- ANALYSIS COMPLETE ---")