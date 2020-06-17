leaf_density_prior_1 <- traits[["leaf_density"]]$prior
leaf_density_prior_2 <- rlnorm(100000, 6.51, .59) # Also trying with lnorm, this is left over from a previous question but I'm including it for now so that the code runs

# Following the equation in ED

SLA_density <-  get_ED_default("/fs/data3/ecowdery/ED.Hydro/parameters/pft3_defaults_history.xml", "SLA")
default_LMA <- 1e3 * 2 / SLA_density # 1.e3 * C2B / SLA(ipft)

leaf_water_sat_density <- get_ED_default("/fs/data3/ecowdery/ED.Hydro/parameters/pft3_defaults_history.xml", "leaf_water_sat")

leaf_water_sat_default_calc <- (-2.32e4 / default_LMA + 782.) * (1. / (-0.21 * log(1.e4 / default_LMA) + 1.43) - 1.) / traits[["leaf_density"]]$default
# c(leaf_water_sat_density, leaf_water_sat_default_calc)

LMA_prior <- 1e3 * 2 / traits[["SLA"]]$prior

# Should be analogous to Christoffersen because I'm dividing by C$wdns instead of leaf_density
leaf_water_sat_samp_1_1 <-
  (-2.32e4 / LMA_prior + 782.) *
  (1. / (-0.21 * log(1.e4 / LMA_prior) + 1.43) - 1.) / leaf_density_prior_1
leaf_water_sat_samp_1_2 <-
  (-2.32e4 / LMA_prior + 782.) *
  (1. / (-0.21 * log(1.e4 / LMA_prior) + 1.43) - 1.) / leaf_density_prior_2

prior_in_1_1 <- data.frame(low.025 =  quantile(leaf_water_sat_samp_1_1, c(.025), na.rm = TRUE),
                           low.25  =  quantile(leaf_water_sat_samp_1_1, c(.25), na.rm = TRUE),
                           mean    =  quantile(leaf_water_sat_samp_1_1, c(.5), na.rm = TRUE),
                           upp.75  =  quantile(leaf_water_sat_samp_1_1, c(.75), na.rm = TRUE),
                           upp.975 =  quantile(leaf_water_sat_samp_1_1, c(.975), na.rm = TRUE))

myfit_1_1 <-  prior_get_fit(prior_in_1_1, accepted_dists, plot = FALSE)
myfit_1_1$score$dist[which.min(myfit_1_1$score$RMSE)]
# I'm skipping steps here just for the sake of time & sanity
leaf_water_sat_prior_1_1 <- rexp(1000, myfit_1_1$dists$exp[1])

prior_in_1_2 <- data.frame(low.025 =  quantile(leaf_water_sat_samp_1_2, c(.025), na.rm = TRUE),
                           low.25  =  quantile(leaf_water_sat_samp_1_2, c(.25), na.rm = TRUE),
                           mean    =  quantile(leaf_water_sat_samp_1_2, c(.5), na.rm = TRUE),
                           upp.75  =  quantile(leaf_water_sat_samp_1_2, c(.75), na.rm = TRUE),
                           upp.975 =  quantile(leaf_water_sat_samp_1_2, c(.975), na.rm = TRUE))

myfit_1_2 <-  prior_get_fit(prior_in_1_2, accepted_dists, plot = FALSE)
myfit_1_2$score$dist[which.min(myfit_1_2$score$RMSE)]
# I'm skipping steps here just for the sake of time & sanity
leaf_water_sat_prior_1_2 <- rlnorm(1000, myfit_1_2$dists$lnorm[1], myfit_1_2$dists$lnorm[2])

# Using the data
i <- which(priors$ED_name == "leaf_water_sat")

myfit_2 <- prior_get_fit(priors[i,], accepted_dists, plot = FALSE)
myfit_2$score$dist[which.min(myfit_2$score$RMSE)]
# I'm skipping steps here just for the sake of time & sanity
leaf_water_sat_prior_2 <- rnorm(1000, myfit_2$dists$norm[1], myfit_2$dists$norm[2])

calc_2_1 <- leaf_water_sat_prior_2 * (C$wdns/(leaf_density_prior_1))
prior_in_2_1 <- data.frame(low.025 =  quantile(calc_2_1, c(.025), na.rm = TRUE),
                           low.25  =  quantile(calc_2_1, c(.25), na.rm = TRUE),
                           mean    =  quantile(calc_2_1, c(.5), na.rm = TRUE),
                           upp.75  =  quantile(calc_2_1, c(.75), na.rm = TRUE),
                           upp.975 =  quantile(calc_2_1, c(.975), na.rm = TRUE))
myfit_2_1 <-  prior_get_fit(prior_in_2_1, accepted_dists, plot = FALSE)
myfit_2_1$score$dist[which.min(myfit_2_1$score$RMSE)]
# I'm skipping steps here just for the sake of time & sanity
leaf_water_sat_prior_2_1 <- rlnorm(1000, myfit_2_1$dists$lnorm[1], myfit_2_1$dists$lnorm[2])


calc_2_2 <- leaf_water_sat_prior_2 * (C$wdns/(leaf_density_prior_2))
prior_in_2_2 <- data.frame(low.025 =  quantile(calc_2_2, c(.025), na.rm = TRUE),
                           low.25  =  quantile(calc_2_2, c(.25), na.rm = TRUE),
                           mean    =  quantile(calc_2_2, c(.5), na.rm = TRUE),
                           upp.75  =  quantile(calc_2_2, c(.75), na.rm = TRUE),
                           upp.975 =  quantile(calc_2_2, c(.975), na.rm = TRUE))
myfit_2_2 <-  prior_get_fit(prior_in_2_2, accepted_dists, plot = FALSE)
myfit_2_2$score$dist[which.min(myfit_2_2$score$RMSE)]
# I'm skipping steps here just for the sake of time & sanity
leaf_water_sat_prior_2_2 <- rlnorm(1000, myfit_2_2$dists$lnorm[1], myfit_2_2$dists$lnorm[2])

df <- data.frame(leaf_water_sat_prior_1_1, #leaf_water_sat_prior_1_2,
                 leaf_water_sat_prior_2_1) #, leaf_water_sat_prior_2_2)
df2 <- df %>%
  gather(key = "prior") %>%
  mutate(leaf_dens_dist = case_when(
    prior == "leaf_water_sat_prior_1_1" ~ "Weibull",
    # prior == "leaf_water_sat_prior_1_2" ~ "Log Normal",
    prior == "leaf_water_sat_prior_2_1" ~ "Weibull",
    # prior == "leaf_water_sat_prior_2_2" ~ "Log Normal"
  )) %>%
  mutate(prior_or_data = case_when(
    prior == "leaf_water_sat_prior_1_1" ~ "LMA_prior",
    # prior == "leaf_water_sat_prior_1_2" ~ "LMA_prior",
    prior == "leaf_water_sat_prior_2_1" ~ "leaf_water_sat_exp_elicit",
    # prior == "leaf_water_sat_prior_2_2" ~ "leaf_water_sat_exp_elicit"
  ))

print(ggplot(data = df2) +
  geom_density(aes(x = value, color = prior_or_data, linetype = leaf_dens_dist)) +
  geom_vline(aes(xintercept = leaf_water_sat_density)) +
  geom_point(aes(x = .03, y = 0)) + geom_point(aes(x = 1.5, y = 0)) + geom_point(aes(x = 2, y = 0)) +
  xlim(-.25, 4))
