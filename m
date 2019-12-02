Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C597510ECB7
	for <lists+kvmarm@lfdr.de>; Mon,  2 Dec 2019 16:58:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47B194AEF4;
	Mon,  2 Dec 2019 10:58:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xda3RbARW+W7; Mon,  2 Dec 2019 10:58:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34A304AEE6;
	Mon,  2 Dec 2019 10:58:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 630F84AEC5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Dec 2019 10:58:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtOzwSJ+gvRL for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Dec 2019 10:58:02 -0500 (EST)
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 67B384AEAB
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Dec 2019 10:58:02 -0500 (EST)
Received: by mail-pl1-f195.google.com with SMTP id o9so97583plk.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 02 Dec 2019 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3tQkWWgh8Usc3X35kIQnFqRXchgCy3Epf2H7wGf4ymM=;
 b=jAJlr2vE4op8JEMuhyx1qT3of2aynCVggeAXRUR8iwyBGiEYTjfWsFjJ4/irlCPlDd
 5vY7qxG1G1QyHAS+v2ebzSmG7HA8nuDFvta5rxDYD+VyvzqcEhfXTDw2cJBM/CmVcOPX
 2grOQU8ah8B97FUi2qto+ouH9KN5C7VVHzgR8zFmIW5i+v9FXDzKfkojxSVIgbIEl2CW
 kNAHLZ79UgZKpk88xjcIZRb/xVgyCpt9jVWun16+c3Y+KryiaM6cne4HTpODHiHAcME/
 qFczFHUCJXuCDUaS8hDVBYgI8ZUxQ8Pa8VSroZivwfWXsAfPmbo7YBY4icEr5ahD60Rt
 YxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3tQkWWgh8Usc3X35kIQnFqRXchgCy3Epf2H7wGf4ymM=;
 b=rNflrkzhJbiWlVZtKDiB47S59zmhoxOz4Vs3+xdAv7kBnqXfFj1nJFsoyglgnGbVNF
 1CrhHLOUCRl94vj9BgVsWdEAu29wWXcuWDOI2/q8YnrzpURSR8rDiHn7joFQhdr8GTDT
 VetY8LEAbQC3H9ItTwj8HRn3YSJu4VtCbgAnMYAD8Sdxixl7VtJNYwsMxZWrcEwPG+ke
 bB8sB68+u1t7B70t6T/6nSqIbEsfug9TrI5jVml6FZ9ZMb2RGk1iwG4mrCg5rQRs9Aik
 tABnssacG4olXdAV0KyMJne3oJRGK1m3dSPJ0zP4K+EZVwMxT07edqV80hQQAneoPr35
 bqGA==
X-Gm-Message-State: APjAAAV/FPbGq6hmyGSuJzD1Vbx9XWu371H70+ELAuVnVRyGCG0PkRCj
 xnoZbRO9k6IWo/lOYKcxm7bc7A==
X-Google-Smtp-Source: APXvYqwJsisP3iKAMVvXHBr/4kWb2M0W4Wt6k3oFQZJffIpuUqLq0l8H4leBy4NR1Cnxn9+6c0rv5w==
X-Received: by 2002:a17:90a:508:: with SMTP id h8mr7117411pjh.91.1575302281500; 
 Mon, 02 Dec 2019 07:58:01 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x11sm3801803pfn.53.2019.12.02.07.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:58:00 -0800 (PST)
Subject: Re: [PATCH v2 5/5] target/arm: Add support for missing Jazelle system
 registers
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-6-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27089f4b-5bd3-04a9-9c16-91474a225c45@linaro.org>
Date: Mon, 2 Dec 2019 07:57:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-6-maz@kernel.org>
Content-Language: en-US
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 kvmarm@lists.cs.columbia.edu
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

On 12/1/19 12:20 PM, Marc Zyngier wrote:
> +    if (cpu_isar_feature(jazelle, cpu)) {
> +        ARMCPRegInfo jazelle_regs[] = {

static const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
