Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4332F26F93C
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 11:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D66C84B435;
	Fri, 18 Sep 2020 05:26:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmmSfOfmAL+B; Fri, 18 Sep 2020 05:26:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D059E4B3C3;
	Fri, 18 Sep 2020 05:26:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E3494B392
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 05:26:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5HzNjwf7hvOx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 05:26:33 -0400 (EDT)
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 280314B351
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 05:26:33 -0400 (EDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 55577A61850A0EE7D8CD;
 Fri, 18 Sep 2020 17:26:31 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 18 Sep 2020 17:26:31 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 18 Sep 2020 17:26:31 +0800
Subject: Re: [RFC v2 5/7] kvm: arm64: implement check_user for ID registers
To: Andrew Jones <drjones@redhat.com>
References: <20200917120101.3438389-1-liangpeng10@huawei.com>
 <20200917120101.3438389-6-liangpeng10@huawei.com>
 <20200918074609.tet63j5x7i7n4wp7@kamzik.brq.redhat.com>
From: Peng Liang <liangpeng10@huawei.com>
Message-ID: <370b5645-edad-e233-0dbe-2459b5d50e1c@huawei.com>
Date: Fri, 18 Sep 2020 17:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918074609.tet63j5x7i7n4wp7@kamzik.brq.redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 9/18/2020 3:46 PM, Andrew Jones wrote:
> On Thu, Sep 17, 2020 at 08:00:59PM +0800, Peng Liang wrote:
>> For most ID registers, only neeed to check each field defined by user
>> space is no more than that in host and only the fields we want to
>> exposed to guest is set.  For some ID registers, the relationship
>> between some fields need to be check or we'd better to keep the same
>> value as host for some fields.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 425 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 424 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 86ebb8093c3c..a642ecfebe0a 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1385,12 +1385,433 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>  	return true;
>>  }
>>  
>> +#define ID_CHECKER(reg) __check_ ##reg
>> +
>> +static int __general_id_checker(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +
>> +	return check_features(reg_id, val);
>> +}
>> +
>> +static int ID_CHECKER(ID_PFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_PFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_PFR2_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_DFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val, host_val;
>> +	u64 mask = ((0xfUL << ID_DFR0_PERFMON_SHIFT) |
>> +		    (0xfUL << ID_DFR0_MMAPDBG_SHIFT) |
>> +		    (0xfUL << ID_DFR0_COPDBG_SHIFT) |
>> +		    (0xfUL << ID_DFR0_COPDBG_SHIFT));
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	host_val = read_sanitised_ftr_reg(reg_id);
>> +	return (val & mask) == (host_val & mask) ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR2_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR3_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR4_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_MMFR5_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR2_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR3_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR4_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR5_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_ISAR6_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(MVFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
> 
> There has to be a better way to handle all these redundant functions...
> 
>> +
>> +static int ID_CHECKER(MVFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val;
>> +	unsigned int fphp, simdhp;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	fphp = cpuid_feature_extract_signed_field(val, MVFR1_FPHP_SHIFT);
>> +	simdhp = cpuid_feature_extract_signed_field(val, MVFR1_SIMDHP_SHIFT);
>> +	return ((fphp == 0 && simdhp == 0) || (fphp == 2 && simdhp == 1) ||
>> +		(fphp == 3 && simdhp == 2)) ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(MVFR2_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64PFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val;
>> +	unsigned int fp, asimd;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	fp = cpuid_feature_extract_signed_field(val, ID_AA64PFR0_FP_SHIFT);
>> +	asimd = cpuid_feature_extract_signed_field(val, ID_AA64PFR0_ASIMD_SHIFT);
>> +	return fp == asimd ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64PFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64DFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val, host_val;
>> +	u64 mask = ((0xfUL << ID_AA64DFR0_PMUVER_SHIFT) |
>> +		    (0xfUL << ID_AA64DFR0_DEBUGVER_SHIFT) |
>> +		    (0xfUL << ID_AA64DFR0_CTX_CMPS_SHIFT) |
>> +		    (0xfUL << ID_AA64DFR0_WRPS_SHIFT) |
>> +		    (0xfUL << ID_AA64DFR0_BRPS_SHIFT));
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	host_val = read_sanitised_ftr_reg(reg_id);
>> +	return (val & mask) == (host_val & mask) ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64DFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64ISAR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val;
>> +	unsigned int sm3, sm4, sha1, sha2, sha3;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	sm3 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SM3_SHIFT);
>> +	sm4 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SM4_SHIFT);
>> +	/*
>> +	 * ID_AA64ISAR0_EL1.SM3 and ID_AA64ISAR0_EL1.SM4 must have the same
>> +	 * value.
>> +	 */
>> +	if (sm3 != sm4)
>> +		return -EINVAL;
>> +
>> +	sha1 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA1_SHIFT);
>> +	sha2 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA2_SHIFT);
>> +	sha3 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA3_SHIFT);
>> +	/*
>> +	 * 1. If the value of ID_AA64ISAR0_EL1.SHA1 is 0, then
>> +	 *    ID_AA64ISAR0_EL1.SHA2 must have the value 0, and vice versa;
>> +	 * 2. If the value of ID_AA64ISAR0_EL1.SHA2 is 2, then
>> +	 *    ID_AA64ISAR0_EL1.SHA3 must have the value 1, and vice versa;
>> +	 * 3. If the value of ID_AA64ISAR0_EL1.SHA1 is 0, then
>> +	 *    ID_AA64ISAR0_EL1.SHA3 must have the value 0;
>> +	 */
>> +	if ((sha1 ^ sha2) || ((sha2 == 2) ^ (sha3 == 1)) || (!sha1 && sha3))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64ISAR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val;
>> +	unsigned int gpi, gpa, api, apa;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	gpi = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR1_GPI_SHIFT);
>> +	gpa = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR1_GPA_SHIFT);
>> +	api = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR1_API_SHIFT);
>> +	apa = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR1_APA_SHIFT);
>> +	/*
>> +	 * 1. If the value of ID_AA64ISAR1_EL1.GPA is non-zero, then
>> +	 *    ID_AA64ISAR1_EL1.GPI must have the value 0;
>> +	 * 2. If the value of ID_AA64ISAR1_EL1.GPI is non-zero, then
>> +	 *    ID_AA64ISAR1_EL1.GPA must have the value 0;
>> +	 * 3. If the value of ID_AA64ISAR1_EL1.APA is non-zero, then
>> +	 *    ID_AA64ISAR1_EL1.API must have the value 0;
>> +	 * 4. If the value of ID_AA64ISAR1_EL1.API is non-zero, then
>> +	 *    ID_AA64ISAR1_EL1.APA must have the value 0;
>> +	 */
>> +	if ((gpi && gpa) || (api && apa))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64MMFR0_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val, host_val;
>> +	u64 mask = ((0xfUL << ID_AA64MMFR0_TGRAN4_2_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_TGRAN64_2_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_TGRAN16_2_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_TGRAN4_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_TGRAN64_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_TGRAN16_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_ASID_SHIFT) |
>> +		    (0xfUL << ID_AA64MMFR0_PARANGE_SHIFT));
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	host_val = read_sanitised_ftr_reg(reg_id);
>> +	return (val & mask) == (host_val & mask) ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64MMFR1_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
>> +			     (u32)rd->CRm, (u32)rd->Op2);
>> +	int err;
>> +	u64 val, host_val;
>> +	unsigned int vmidbits, host_vmidbits;
>> +
>> +	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
>> +	if (err)
>> +		return err;
>> +	err = check_features(reg_id, val);
>> +	if (err)
>> +		return err;
>> +
>> +	vmidbits = cpuid_feature_extract_unsigned_field(val, ID_AA64MMFR1_VMIDBITS_SHIFT);
>> +	host_val = read_sanitised_ftr_reg(reg_id);
>> +	host_vmidbits = cpuid_feature_extract_signed_field(host_val, ID_AA64MMFR1_VMIDBITS_SHIFT);
>> +	return vmidbits == host_vmidbits ? 0 : -EINVAL;
>> +}
>> +
>> +static int ID_CHECKER(ID_AA64MMFR2_EL1)(struct kvm_vcpu *vcpu,
>> +				const struct sys_reg_desc *rd,
>> +				const struct kvm_one_reg *reg,
>> +				void __user *uaddr)
>> +{
>> +	return __general_id_checker(vcpu, rd, reg, uaddr);
>> +}
>> +
>>  /* sys_reg_desc initialiser for known cpufeature ID registers */
>>  #define ID_SANITISED(name) {			\
>>  	SYS_DESC(SYS_##name),			\
>>  	.access	= access_id_reg,		\
>>  	.get_user = get_id_reg,			\
>>  	.set_user = set_id_reg,			\
>> +	.check_user = ID_CHECKER(name),		\
> 
> This patch makes it clear that continuing to use ID_SANITISED() for all ID
> registers makes no sense.
> 
>>  }
>>  
>>  /*
>> @@ -1512,7 +1933,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  	ID_SANITISED(ID_AA64PFR1_EL1),
>>  	ID_UNALLOCATED(4,2),
>>  	ID_UNALLOCATED(4,3),
>> -	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, .visibility = sve_id_visibility },
>> +	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1,
>> +	  .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1,
>> +	  .check_user = __general_id_checker, .visibility = sve_id_visibility },
>>  	ID_UNALLOCATED(4,5),
>>  	ID_UNALLOCATED(4,6),
>>  	ID_UNALLOCATED(4,7),
>> -- 
>> 2.26.2
>>
> 
> Thanks,
> drew 
> 
> .
> 

I also think this patch is a little ugly.  I will refactor the code to
remove the sharing set_user of ID registers in next version.

Thanks,
Peng
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
