defmodule OsBlog.ErrorCode do
  defmodule InvalidCodeError do
    defexception [:message]
  end

  @app_error_codes [
    :bad_request,
    :unauthenticated,
    :unauthorized,
    :not_found,
    :validation_error,
    :internal_server_error,
    :email_verification_error,
    :reset_password_error,
    :oauth_error,
    :oauth_already_used_error,
    :not_enough_money_error,
    :stale_entry_error,
    :survey_readonly_error,
    :survey_not_exist,
    # 问卷已下线，用于 client 端的 survey 和 response API
    :survey_offline,
    :diagram_has_errors,
    :httpoison_error,
    # 创建 response 时，interviewee_id 未提供
    :interviewee_missing_error,
    # 创建 response 时，提供了 interviewee 但与 channel config 不匹配
    :interviewee_invalid_error,
    # 创建 response 时，collector 限制多次回复但同一个用户提交了多个回复
    :multi_responses_error,
    # api 调用次数过于频繁
    :api_rate_limit_error,
    # response 当前状态不允许进行某些操作，用于 response 和 validation 的某些 API
    :response_status_error,
    # 创建 validation 时，question 未找到
    :question_missing_error,
    # 创建 image validation 失败
    :gen_validation_error,
    # 手机号格式验证失败
    :invalid_phone_number_error,
    # 相关服务调用失败，比如 短信 和 七牛
    :gateway_error,
    # 客户端提交的 code 跟 validation 不一致
    :invalid_code_error,
    # 重复邀请已接受 team 邀请的 user
    :repeated_invitation_error,
    :accepted_invitation_error,
    # 邀请团队成员时没有足够的席位
    :not_enough_seats,
    # 无效的配额，发布时会检查
    :quota_invalid,
    # 配额绑定的收集器在线，无法更改配额表
    :quota_online,
    # 配额已满，在发布和甄别提交时检查
    :quota_full,
    # 收集器已满，在发布和 collector limiter 检查时返回
    :collector_full,
    # 无法匹配配额设置
    :quota_not_match,
    # 配额检查器无法重复启动
    :quota_already_started,
    # 无法启动配额检查器，因为已经存在同名检查器
    :checker_already_started,
    # 无效的 reward 类型, 如: 向红包奖励的 reward 发送短信
    :reward_type_error,
    # 奖品已核销，无法重复发送
    :already_been_verificated,
    # 无法启动问卷数量检查器
    :limiter_already_started,
    # 因为各种原因无法修改属性
    :modify_error,
    # collector 在 unpublishing 状态下无法修改任何属性
    :collector_status_error,
    # collector 发布时，review 状态检查失败
    :collector_needs_review,
    # 发放过奖励的 gift 和 lottery 节点无法被删除
    :reward_ref_error,
    # 问卷结构无效
    :normalize_diagram_failed,
    # 导出结果状态不对，用于下载时判断导出结果是否成功
    :export_result_status_error,
    # 作为 quota 条件的节点无法被修改或删除
    :quota_ref_error,
    # 数据展示页无法正确转换回复数据
    :transform_body_rows_error,
    # 同一用户在同一 Collector 下无法重复领取红包
    :red_envelope_duplicated,
    # 红包已过期
    :red_envelope_expired,
    # 红包已被用户领取
    :red_envelope_received_by_yourself,
    # 红包已被他人领取
    :red_envelope_received_by_others,
    # 红包已被微信拦截
    :red_envelope_intercepted,
    # 红包发放失败
    :red_envelope_send_error,
    # 问卷状态错误, 无法删除或上线问卷
    :survey_status_error,
    # 收集器仍有冻结金额, 无法被删除
    :collector_under_freezing,
    # 高级功能使用权限验证失败
    :feature_check_error,
    # 复制 template 的 diagram 过程出错
    :template_error,
    # 模板状态错误
    :template_status_error,
    # 修改答案时, 问卷中有节点正在计算
    :in_calculating_error,
    # 筛选器若已经被使用则无法删除
    :filter_undeletable,
    # 无法分析数据
    :can_not_analysis,
    # 分析结果为空
    :empty_analysis_stat,
    # 分析需要的权重配置无效
    :invalid_weight,
    # 更改 team 审核设置时，已有同步在进行中
    :review_syncing,
    # 直接导出 card 时错误
    :export_error,
    # 绑定了红包的收集器，无法无限收集
    :collector_can_not_publish_with_unlimited,
    # 问卷结构包含非离线内容，不能收集器
    :can_not_publish_offline_collector,
    # 权重表在使用中，无法被删除
    :weight_in_use,

    # 收集器监控相关 APIs
    # 历史数据 API ，收集器生命周期不正确，通常因为收集器不是离线状态
    :"collector_metrics.lifecycle_error",

    # Plan subscription
    # 后台任务没成功 enqueue ，基本不会出现
    :"plan_subscription.job_not_enqueued",
    # 没有延迟改动可取消
    :"plan_subscription.no_pending_change",
    # 订阅过期
    :"plan_subscription.subscription_expired",

    # Result 功能相关
    # 无效的数据源，可能是数据源发生变动或者配置不匹配数据源
    :"result.invalid_source",

    # Public link
    :"public_link.invalid_passcode"
  ]

  @error_codes @app_error_codes

  def validate_code!(code) when code in @error_codes do
    :ok
  end

  def validate_code!(code) do
    raise InvalidCodeError, "Invalid error code '#{code}', you should add it to the @error_codes"
  end
end
