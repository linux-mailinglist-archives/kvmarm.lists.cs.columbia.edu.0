Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CC23D2A253B
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 08:32:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DD344B542;
	Mon,  2 Nov 2020 02:32:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04tMbG0v2nWV; Mon,  2 Nov 2020 02:32:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E45704B53D;
	Mon,  2 Nov 2020 02:32:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78B874B4C0
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 02:32:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqqwwgEHJsa8 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 02:32:10 -0500 (EST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 31A2F4B456
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 02:32:10 -0500 (EST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CPl3h0Jm3z50Y5;
 Mon,  2 Nov 2020 15:32:00 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 2 Nov 2020 15:32:01 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 2 Nov 2020 15:32:01 +0800
Subject: Re: VM live migration failed from Linux v5.9 to Linux v5.10-rc1
From: Peng Liang <liangpeng10@huawei.com>
To: Marc Zyngier <maz@kernel.org>
References: <5ade34aa-e725-93e8-7b28-83fb25dcf896@huawei.com>
 <87blgieddu.wl-maz@kernel.org>
 <05de753e-1845-e23f-7ab2-eaa8d53f0ac5@huawei.com>
Message-ID: <a2dc9044-ed84-78f3-b1c4-3a2388073488@huawei.com>
Date: Mon, 2 Nov 2020 15:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <05de753e-1845-e23f-7ab2-eaa8d53f0ac5@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On 11/2/2020 11:12 AM, Peng Liang wrote:
> Hi Marc,
> Sorry for my late reply.
> 
> On 10/31/2020 9:25 PM, Marc Zyngier wrote:
>> Hi Peng,
>>
>> [+Will, as we hacked the new ECE (Ectoplasmic Control Enclosure) together]
>>
>> On Sat, 31 Oct 2020 07:03:02 +0000,
>> Peng Liang <liangpeng10@huawei.com> wrote:
>>>
>>> [...]
>>>
>>> I found that the different register and the different field between
>>> source and destination is ID_AA64PFR0_EL1.CSV2. I searched in git log
>>> and found that the commit e1026237f9067 ("KVM: arm64: Set CSV2 for
>>> guests on hardware unaffected by Spectre-v2") may be the cause of the
>>> failure?
>>
>> Thanks for the thorough analysis. Yes, this could well be the issue if
>> CSV2 isn't explicitly set at the source, and is now set on the target.
>> For confirmation, what is the value of ID_AA64PFR0_EL1.CSV2 on the
>> host?  What does /sys/devices/system/cpu/vulnerabilities/spectre_v2
>> contain?
> 
> On host:
>   ID_AA64PFR0_EL1.CSV2: 0
>   /sys/devices/system/cpu/vulnerabilities/spectre_v2: Not affected
> 
>>
>>> So do we need to make it possible to migrate VMs between Linux v5.9 and
>>> Linux v5.10-rc1 with QEMU?
>>
>> We should fix the migration from 5.9 to 5.10. I don't plan to support
>> migrating in the other direction, which is consistent with new sysregs
>> and features appearing in the sysreg space over time (although I would
>> expect 5.9 -> 5.10 -> 5.9 to work once we fix this issue).
> 
> BTW, there always be new sysregs/features introduced to kernel over
> time.  If that happened, do we need to make migration successful from a
> older version without the new sysregs/features?  I think there is no
> reason to not allow migration from old version to new version if the
> source end and the destination end have the same hardware just because
> old version doesn't expose some sysregs/features to guest but new
> version does.
> 
>>
>> Could you please give the patch below a go? I have boot-tested it, but
>> I'm not really equipped to test live migration.
> 
> Great!  I'll test live migration as soon as possible.

I applied the patch on v5.10-rc2, then the migration v5.9 -> v5.10 ->
v5.9 is successful.

Thanks,
Peng

> 
> Thanks,
> Peng
> 
>>
>> Thanks,
>>
>> 	M.
>>
>> >From 2b9202538365bacc0abd01142800234ea1bc5bde Mon Sep 17 00:00:00 2001
>> From: Marc Zyngier <maz@kernel.org>
>> Date: Sat, 31 Oct 2020 12:28:50 +0000
>> Subject: [PATCH] KVM: arm64: Allow setting of ID_AA64PFR0_EL1.CSV2 from
>>  userspace
>>
>> We now expose ID_AA64PFR0_EL1.CSV2=1 to guests running on hosts
>> that are immune to Spectre-v2, but that don't have this field set,
>> most likely because they predate the specification.
>>
>> However, this prevents the migration of guests that have started on
>> a host the doesn't fake this CSV2 setting to one that does, as KVM
>> rejects the write to ID_AA64PFR0_EL2 on the grounds that it isn't
>> what is already there.
>>
>> In order to fix this, allow userspace to set this field as long as
>> this doesn't result in a promising more than what is already there
>> (setting CSV2 to 0 is acceptable, but setting it to 1 when it is
>> already set to 0 isn't).
>>
>> Fixes: e1026237f9067 ("KVM: arm64: Set CSV2 for guests on hardware unaffected by Spectre-v2")
>> Reported-by: Peng Liang <liangpeng10@huawei.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/include/asm/kvm_host.h |  2 ++
>>  arch/arm64/kvm/arm.c              | 21 +++++++++++++++++
>>  arch/arm64/kvm/sys_regs.c         | 38 +++++++++++++++++++++++++++----
>>  3 files changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 0aecbab6a7fb..160d783eaf89 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -118,6 +118,8 @@ struct kvm_arch {
>>  	 */
>>  	unsigned long *pmu_filter;
>>  	unsigned int pmuver;
>> +
>> +	u8 pfr0_csv2;
>>  };
>>  
>>  struct kvm_vcpu_fault_info {
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index f56122eedffc..1a944c9b48b4 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -102,6 +102,25 @@ static int kvm_arm_default_max_vcpus(void)
>>  	return vgic_present ? kvm_vgic_get_max_vcpus() : KVM_MAX_VCPUS;
>>  }
>>  
>> +static void set_default_csv2(struct kvm *kvm)
>> +{
>> +	u64 val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
>> +
>> +	/*
>> +	 * The default is to expose CSV2 == 1 if the HW isn't affected
>> +	 * but doesn't have CSV2 baked in the PFR0 register. Although
>> +	 * this is a per-CPU feature, we make it global because
>> +	 * asymmetric systems are just a nuisance.
>> +	 *
>> +	 * Userspace can override this as long as it doesn't promise
>> +	 * the impossible.
>> +	 */
>> +	kvm->arch.pfr0_csv2 = FIELD_GET(0xfUL << ID_AA64PFR0_CSV2_SHIFT, val);
>> +	if (!kvm->arch.pfr0_csv2 &&
>> +	    arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED)
>> +		kvm->arch.pfr0_csv2 = 1;
>> +}
>> +
>>  /**
>>   * kvm_arch_init_vm - initializes a VM data structure
>>   * @kvm:	pointer to the KVM struct
>> @@ -127,6 +146,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>  	/* The maximum number of VCPUs is limited by the host's GIC model */
>>  	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
>>  
>> +	set_default_csv2(kvm);
>> +
>>  	return ret;
>>  out_free_stage2_pgd:
>>  	kvm_free_stage2_pgd(&kvm->arch.mmu);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index d9117bc56237..4f5716abbb19 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1128,9 +1128,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>>  		if (!vcpu_has_sve(vcpu))
>>  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>>  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>> -		if (!(val & (0xfUL << ID_AA64PFR0_CSV2_SHIFT)) &&
>> -		    arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED)
>> -			val |= (1UL << ID_AA64PFR0_CSV2_SHIFT);
>> +		val &= ~(0xfUL << ID_AA64PFR0_CSV2_SHIFT);
>> +		val |= ((u64)vcpu->kvm->arch.pfr0_csv2 << ID_AA64PFR0_CSV2_SHIFT);
>>  	} else if (id == SYS_ID_AA64PFR1_EL1) {
>>  		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>>  	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>> @@ -1260,6 +1259,36 @@ static int set_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
>>  	return 0;
>>  }
>>  
>> +static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
>> +			       const struct sys_reg_desc *rd,
>> +			       const struct kvm_one_reg *reg, void __user *uaddr)
>> +{
>> +	const u64 id = sys_reg_to_index(rd);
>> +	int err;
>> +	u64 val;
>> +	u8 csv2;
>> +
>> +	err = reg_from_user(&val, uaddr, id);
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Allow AA64PFR0_EL1.CSV2 to be set from userspace as long as
>> +	 * it doesn't promise more than what is actually provided (the
>> +	 * guest could otherwise be covered in ectoplasmic residue).
>> +	 */
>> +	csv2 = FIELD_GET(0xfUL << ID_AA64PFR0_CSV2_SHIFT, val);
>> +	if (csv2 > vcpu->kvm->arch.pfr0_csv2)
>> +		return -EINVAL;
>> +	vcpu->kvm->arch.pfr0_csv2 = csv2;
>> +
>> +	/* This is what we mean by invariant: you can't change it. */
>> +	if (val != read_id_reg(vcpu, rd, false))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * cpufeature ID register user accessors
>>   *
>> @@ -1514,7 +1543,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  
>>  	/* AArch64 ID registers */
>>  	/* CRm=4 */
>> -	ID_SANITISED(ID_AA64PFR0_EL1),
>> +	{ SYS_DESC(SYS_ID_AA64PFR0_EL1), .access = access_id_reg,
>> +	  .get_user = get_id_reg, .set_user = set_id_aa64pfr0_el1, },
>>  	ID_SANITISED(ID_AA64PFR1_EL1),
>>  	ID_UNALLOCATED(4,2),
>>  	ID_UNALLOCATED(4,3),
>>
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
