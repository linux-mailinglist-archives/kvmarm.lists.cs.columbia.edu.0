Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC42ED7C0B
	for <lists+kvmarm@lfdr.de>; Tue, 15 Oct 2019 18:39:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FCB44A9D3;
	Tue, 15 Oct 2019 12:39:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oq4aT1F82JfN; Tue, 15 Oct 2019 12:39:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DA994A9CE;
	Tue, 15 Oct 2019 12:39:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 177EF4A9C5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Oct 2019 12:39:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FX2rzvFMoYfg for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Oct 2019 12:39:36 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B5214A9A1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Oct 2019 12:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571157575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ojp02z/yPeUqI0YPPrqnloEvXX8pMYJM8GdkxYvWth0=;
 b=PoZFMYJ+7sxpeBeXtCRLK0g6oDkA2z3n2r34/NjLf7wdxXvZziHotiUaKgZ841qK2cavjw
 WJTc0ZeONaEJz/JxZjjDFMWCAOib/txMjSJCFMYErkwz86H4bzEy2FPiV9gbD0wOY2yEvO
 yAwZe9GWPTTBtgmmcFuCQ7GonvMsogw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-cA8ZzNyLP_GslEtJr9UGig-1; Tue, 15 Oct 2019 12:39:29 -0400
Received: by mail-wm1-f70.google.com with SMTP id z205so8904849wmb.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Oct 2019 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o8Yzcui6UO5aokPFK9KbVMAamgpXNzxTPApyteJcIxI=;
 b=UfIMK556HGj+tfipYEhj6jUIEA3WNpjX/R0mNL6lkYnJbVQl0AtVbX5v1EdEjznLL4
 NoXa3X/PyAxMHpiffGElbAQXhfKFZCHmQWcIM2KcKgxUUYcmHGsILf7WDhs9aTWBknpR
 oJsdK6QMbNje76wc25Qy0I3oPc6doB2fAlQQ4Gxq4p2oDlBZLLMw7ql/fNBncso67NRK
 kJSP7Gco1TuWhvSFKbIiES7WU2Q8Id7tnj+9+6NyhmeQDLPCaZ2qsvPEh9xRqX2+XM2+
 sQf+hIG59uqicwVctBNOuZQLGmUVXQ2vaEOfNAss5Gu7FnqkiaXS/61kCYhIvllCmvFg
 VLSQ==
X-Gm-Message-State: APjAAAVatROO/RV/ZN1zZc5JCoi+Q6wbO2G/A+z5y1ImU2i291+AkAqy
 2yJY4jDCO/V0yIhUZYQOKFhHCW/7XS4poZnCQm1Vq2DRKktX3+nwicVdsJW1BNfF+87NR8iCZgc
 syFJWE2RjLBjY/Ji/Yab5Cskw
X-Received: by 2002:adf:e747:: with SMTP id c7mr935238wrn.384.1571157568342;
 Tue, 15 Oct 2019 09:39:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyejSMH01cdqlKyvOUSnepj7nqszueGVbjXDXwAp7a2kqRNxQBtic0nSge519tsU28CGqWN0A==
X-Received: by 2002:adf:e747:: with SMTP id c7mr935204wrn.384.1571157568078;
 Tue, 15 Oct 2019 09:39:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41?
 ([2001:b07:6468:f312:d001:591b:c73b:6c41])
 by smtp.gmail.com with ESMTPSA id h7sm20388863wrs.15.2019.10.15.09.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 09:39:27 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
To: Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
 yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
 sean.j.christopherson@intel.com, maz@kernel.org, richardcochran@gmail.com,
 Mark.Rutland@arm.com, will@kernel.org, suzuki.poulose@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-6-jianyong.wu@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <da62c327-9402-9a5c-d694-c1a4378822e0@redhat.com>
Date: Tue, 15 Oct 2019 18:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104822.13890-6-jianyong.wu@arm.com>
Content-Language: en-US
X-MC-Unique: cA8ZzNyLP_GslEtJr9UGig-1
X-Mimecast-Spam-Score: 0
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 15/10/19 12:48, Jianyong Wu wrote:
> +int kvm_arch_ptp_get_clock_generic(struct timespec64 *ts,
> +				   struct arm_smccc_res *hvc_res)
> +{
> +	u64 ns;
> +	ktime_t ktime_overall;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
> +				  hvc_res);
> +	if ((long)(hvc_res->a0) < 0)
> +		return -EOPNOTSUPP;
> +
> +	ktime_overall = hvc_res->a0 << 32 | hvc_res->a1;
> +	*ts = ktime_to_timespec64(ktime_overall);
> +
> +	return 0;
> +}
> +

This seems wrong, who uses kvm_arch_ptp_get_clock_fn?

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
