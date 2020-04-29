Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9154C1BE475
	for <lists+kvmarm@lfdr.de>; Wed, 29 Apr 2020 18:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0990C4B422;
	Wed, 29 Apr 2020 12:58:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NB41LjYpxXen; Wed, 29 Apr 2020 12:58:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9252A4B39F;
	Wed, 29 Apr 2020 12:58:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F2AC4B385
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 08:03:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cl5xu+TbXhLb for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Apr 2020 08:03:55 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F47F4B384
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 08:03:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVvnsQYJBmlhPz+VOWOkjerwwm6oNBR0crQtJmB/QvU=;
 b=MvafjDh0ME65yh6CL0VSTqE/Qep1fH6TmkF/Y5+grm8SY/BH8tUFcY/kpnWkjnm03QmiNq
 q12cStWux86jWMZWiafD52CEQ2PYdezQ/0TvoMQHexq+77tnCVlfVUOuPmWya5eXROGxQi
 3lu/d3/UU2DnZ8B50ofePYij9N3833g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-1WjAp9mPMjKuha7cEh_zAA-1; Wed, 29 Apr 2020 08:03:53 -0400
X-MC-Unique: 1WjAp9mPMjKuha7cEh_zAA-1
Received: by mail-wr1-f71.google.com with SMTP id g7so1591551wrw.18
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 05:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=PqLyCXunZj5hIFRUBscgO/EQSOL9w9OMkdGXwDOCk6M=;
 b=CAx3Vrr+c8HQCFhq5msDZh9lnyfzONW3JGBMk/hAolYGc77iDgHDokECCtXfUKqixd
 I0jXQO1jdGJMrwR5q7HyKbrGp9+9indmwY53Nw8gx6BRUBKpOy55IbbAZ9p+OW/zexq1
 Dtm+G/MqkjXbSD/MhuuR0h5MJpveU90Ct+3vibB6xbEPGB1Z+nWoiOI52lCsxl6C9scr
 B+fzuNy8LivEyJIw/wUsX+jSZbJWGNeoBWueT5onzGvJw0VEN57097GZ5iG3OFiDloce
 EnZvCExJUd7083TH7Xc9t89uEtsbtaQoiVeTfFTH28Ozw85tHpIcgSp4RMGaTtzHatpu
 CeoQ==
X-Gm-Message-State: AGi0Puay7PPAGpMU1G6m87612f1oZUwy0SfxkdXQWGYwbZDfW+THd+pd
 MXiNpY61/4r2XyQSDmXBq5x4iVoRR8qTxFtWjjR/Sl0iwWGsMe08P1ugSJ6D62VDw1mysGJops7
 Kq/iCkfMpdO1na9I3tzJqV2b1
X-Received: by 2002:a5d:470a:: with SMTP id y10mr38056960wrq.63.1588161831812; 
 Wed, 29 Apr 2020 05:03:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLf4KZ8Rngx22ZnSSPEeNNoZEwjNixMH7nATd8iA4vBWIWJ++JJzRvFnPP9z8By88bEDzPwkg==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr38056907wrq.63.1588161831501; 
 Wed, 29 Apr 2020 05:03:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id h16sm33279920wrw.36.2020.04.29.05.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 05:03:46 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v4 1/7] KVM: s390: clean up redundant 'kvm_run' parameters
In-Reply-To: <20200427043514.16144-2-tianjia.zhang@linux.alibaba.com>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-2-tianjia.zhang@linux.alibaba.com>
Date: Wed, 29 Apr 2020 14:03:41 +0200
Message-ID: <87r1w6h52a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Wed, 29 Apr 2020 12:58:34 -0400
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, david@redhat.com,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, paulus@ozlabs.org, hpa@zytor.com,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, chenhuacai@gmail.com, mpe@ellerman.id.au,
 joro@8bytes.org, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com,
 thuth@redhat.com, gor@linux.ibm.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 tsbogend@alpha.franken.de, tianjia.zhang@linux.alibaba.com, cohuck@redhat.com,
 linux-mips@vger.kernel.org, sean.j.christopherson@intel.com, maz@kernel.org,
 pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
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

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e335a7e5ead7..c0d94eaa00d7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4176,8 +4176,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  	return rc;
>  }
>  
> -static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
>  	struct runtime_instr_cb *riccb;
>  	struct gs_cb *gscb;
>  
> @@ -4243,8 +4244,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	/* SIE will load etoken directly from SDNX and therefore kvm_run */
>  }
>  
> -static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void sync_regs(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
>  		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
> @@ -4273,7 +4276,7 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  
>  	/* Sync fmt2 only data */
>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu))) {
> -		sync_regs_fmt2(vcpu, kvm_run);
> +		sync_regs_fmt2(vcpu);
>  	} else {
>  		/*
>  		 * In several places we have to modify our internal view to
> @@ -4292,8 +4295,10 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	kvm_run->kvm_dirty_regs = 0;
>  }
>  
> -static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void store_regs_fmt2(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	kvm_run->s.regs.todpr = vcpu->arch.sie_block->todpr;
>  	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
>  	kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
> @@ -4313,8 +4318,10 @@ static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	/* SIE will save etoken directly into SDNX and therefore kvm_run */
>  }
>  
> -static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void store_regs(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	kvm_run->psw_mask = vcpu->arch.sie_block->gpsw.mask;
>  	kvm_run->psw_addr = vcpu->arch.sie_block->gpsw.addr;
>  	kvm_run->s.regs.prefix = kvm_s390_get_prefix(vcpu);
> @@ -4333,7 +4340,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
>  	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu)))
> -		store_regs_fmt2(vcpu, kvm_run);
> +		store_regs_fmt2(vcpu);
>  }
>  
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> @@ -4371,7 +4378,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		goto out;
>  	}
>  
> -	sync_regs(vcpu, kvm_run);
> +	sync_regs(vcpu);
>  	enable_cpu_timer_accounting(vcpu);
>  
>  	might_fault();
> @@ -4393,7 +4400,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	}
>  
>  	disable_cpu_timer_accounting(vcpu);
> -	store_regs(vcpu, kvm_run);
> +	store_regs(vcpu);
>  
>  	kvm_sigset_deactivate(vcpu);

Haven't tried to compile this but the change itself looks obviously
correct, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
