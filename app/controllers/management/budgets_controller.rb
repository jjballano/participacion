class Management::BudgetsController < Management::BaseController
  include FeatureFlags
  include HasFilters
  feature_flag :budgets

  before_action :only_verified_users, except: :print_investments

  def create_investments
    @budgets = Budget.accepting.order(created_at: :desc).page(params[:page])
  end

  def support_investments
    @budgets = Budget.selecting.order(created_at: :desc).page(params[:page])
  end

  def print_investments
    @budgets = Budget.current.order(created_at: :desc).page(params[:page])
  end

  private

    def only_verified_users
      check_verified_user t("management.budget_investments.alert.unverified_user")
    end

end
