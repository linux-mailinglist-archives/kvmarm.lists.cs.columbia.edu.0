Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C4A45403A04
	for <lists+kvmarm@lfdr.de>; Wed,  8 Sep 2021 14:39:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76D804B106;
	Wed,  8 Sep 2021 08:39:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Akya3-5aWh1; Wed,  8 Sep 2021 08:39:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47D5C4B103;
	Wed,  8 Sep 2021 08:39:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E301407F1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 08:39:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GoNANiIr-yju for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 08:39:12 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E061E4B090
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 08:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631104752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJk9DPikcEEEFmKWzBbvekDGUKQO1oc5fhwtnVuechI=;
 b=VOrC+WHUNm+S7u41WiVImVFIlDxfthvppKXKyaGMHWv1FSgFCmeapTcdZx+NEN2mIafAis
 GRHouc7jWrSJBS2qqzsNrMDXb9tCFqceW72M72azsMJ4c3wWVmcPmmNwz/bA6LFV2a/2HU
 slsSaTLreZD9JtZTSITyfAbsytUtfzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-LpEGetJeMju89wVuD5T6gg-1; Wed, 08 Sep 2021 08:39:11 -0400
X-MC-Unique: LpEGetJeMju89wVuD5T6gg-1
Received: by mail-wm1-f72.google.com with SMTP id
 y24-20020a7bcd98000000b002eb50db2b62so799724wmj.5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 05:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qJk9DPikcEEEFmKWzBbvekDGUKQO1oc5fhwtnVuechI=;
 b=WTjs8aYeuZlyoL8hS+zwJqZ8Z0uuCBNGSwKRwFrZB5sWq3w1E4rdQcyCzhFs/FmCfM
 pGmYfuYkbXDW/pH3IOL8bZV5bWcwOKiOejvtHl0/K49Wj3YXQw+hqA3CtPdWWcUG23ll
 h4ScwuiTsVbBSpSjEjT1rXNsfJ4p1ZUS2Hkt5/ds0k0gvVG8N5pj9poTi014+4uOWifE
 kKR36QInkJTd4k+KecoEpLWsusad47WCYt3PO9tVyYTR5oHQP+wPG5DLXDrSWEsbu7M/
 nYEDm31sTPd0kjxnZSfWNtjwqjmgDnzCTBECKt6l3kITDeexSUCRD8WcM2VvQW/Ca6EH
 LLSw==
X-Gm-Message-State: AOAM5322DI/jyGKo+lhJoel8d4UMEE3jyspSkufV40AzC4mxDrOYjQ5d
 3axCNV1+vjtR9i8P7SaFOLliaXyEAzTE2dYaEfCnbn0zqW+YAvi7HmJqIEpIahqZl554GAZgfnI
 /yqjGIjJQe8dqWCqWQ26sfYRV
X-Received: by 2002:aa7:cfd2:: with SMTP id r18mr3792145edy.82.1631104740790; 
 Wed, 08 Sep 2021 05:39:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjid3++di+F5iCU9+5CzYDTvq+wLZRd9DcKg7WpI/zFqCadUN/JE18oA3HheHdzPjP0LYM/w==
X-Received: by 2002:aa7:cfd2:: with SMTP id r18mr3792124edy.82.1631104740608; 
 Wed, 08 Sep 2021 05:39:00 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id bm14sm1157297edb.71.2021.09.08.05.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 05:39:00 -0700 (PDT)
Date: Wed, 8 Sep 2021 14:38:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v5 3/8] KVM: arm64: Simplify masking out MTE in feature
 id reg
Message-ID: <20210908123858.fqoltrkp3aodj4ly@gator>
References: <20210827101609.2808181-1-tabba@google.com>
 <20210827101609.2808181-4-tabba@google.com>
MIME-Version: 1.0
In-Reply-To: <20210827101609.2808181-4-tabba@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 27, 2021 at 11:16:04AM +0100, Fuad Tabba wrote:
> Simplify code for hiding MTE support in feature id register when
> MTE is not enabled/supported by KVM.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 1d46e185f31e..447acce9ca84 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1077,14 +1077,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3), (u64)vcpu->kvm->arch.pfr0_csv3);
>  		break;
>  	case SYS_ID_AA64PFR1_EL1:
> -		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
> -		if (kvm_has_mte(vcpu->kvm)) {
> -			u64 pfr, mte;
> -
> -			pfr = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
> -			mte = cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR1_MTE_SHIFT);
> -			val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR1_MTE), mte);
> -		}
> +		if (!kvm_has_mte(vcpu->kvm))
> +			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
>  		break;
>  	case SYS_ID_AA64ISAR1_EL1:
>  		if (!vcpu_has_ptrauth(vcpu))
> -- 
> 2.33.0.259.gc128427fd7-goog
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
