Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F15E610ECA9
	for <lists+kvmarm@lfdr.de>; Mon,  2 Dec 2019 16:52:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86D654AEAB;
	Mon,  2 Dec 2019 10:52:43 -0500 (EST)
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
	with ESMTP id jrAeu4sNCH1G; Mon,  2 Dec 2019 10:52:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 826B14AEE6;
	Mon,  2 Dec 2019 10:52:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AA3A4AEC5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Dec 2019 10:52:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QV2M8L6-j0g8 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Dec 2019 10:52:40 -0500 (EST)
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 17E254AEAB
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Dec 2019 10:52:40 -0500 (EST)
Received: by mail-pg1-f194.google.com with SMTP id t3so18092777pgl.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 02 Dec 2019 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gqxsmiAV7JV1SONG7XrgAI1qIjgS9GyeEQFLfkiVFD4=;
 b=Pq92iD6jSYY+Ddpfv6Dp5gg9SJCEnRLUPS/7ajDa44KmJyecfS+x5TfeL0on5o0Lwm
 zwzTjOSIB7OZsF+OA4+WPsaL0FEvikO/O28zSNB5JAyGCiNXhIw2Zq2NhrBUZPRWacfv
 jTOAYx9vZh3m/OTCYSls3KNvpKcUiHjmE2+lalTeRUt5QH8lhbXIJhe041ROhTFU4Sfz
 2oTO4y9yWpde03wDwWg8EYE0bJeFQ+5Paya0+LcGHIsya6BCP3JbXF+qd/mv6D6ktB20
 PhBbj9uW9j7vh/yUAKzEeh+CmP6SJW4Z02muxIYGE0Z9O96JNFQsG0CGEomZwaWFALPm
 y8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gqxsmiAV7JV1SONG7XrgAI1qIjgS9GyeEQFLfkiVFD4=;
 b=n9IxWHhpSuPyqteyFg1g8jOmojkoEWbfweQ4sQCDVH+cwGz0pvEyDS84o+uBKa47q1
 oDzdV2Y+osCcoL+fWUWa1XPsWVkUqMJab72WKazzIAnJCC3ZWaYBZYkwTt8BAGxFpi+m
 gFK/M0O+Dw9jfosXwFnvugN/do7u3QRgjS4ZkF432JBu8bSWPsa/X5FJLmopcce8/WNb
 9MA07hjibhW3uc8SR7VpDCyo5jU8wzRtGsjEyk15oLn4NjgksYUI5Wy6u0piddt7jz6n
 n4iSsPHJB6mN9QGkuNsLvpwzu8cNul/n4j/WXc7qgGIdNgMUO376XhWhm8g3RsE0yDsf
 /E0A==
X-Gm-Message-State: APjAAAUqQhJpgJ88Tz49a56Tanaq5JEZLG6D0B3QjoCaUHMU+HpX8lXr
 u0v22/fbCcVRTIih7dgpoYR5xg==
X-Google-Smtp-Source: APXvYqxxWz256voFtzIHZgU8EratAp/k2RNw2W/RSW4y9Und1CdhZvQjCmdQlDoVfX8eKNj8bdDasA==
X-Received: by 2002:a63:364d:: with SMTP id d74mr32507600pga.408.1575301959004; 
 Mon, 02 Dec 2019 07:52:39 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o23sm35484257pgj.90.2019.12.02.07.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:52:38 -0800 (PST)
Subject: Re: [PATCH v2 4/5] target/arm: Handle AArch32 CP15 trapping via
 HSTR_EL2
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-5-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be437b20-20d7-ebbe-b3b2-8db45774fbbf@linaro.org>
Date: Mon, 2 Dec 2019 07:52:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-5-maz@kernel.org>
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
> +    /* Check for an EL2 trap due to HSTR_EL2. We expect EL0 accesses
> +     * to sysregs non accessible at EL0 to have UNDEF-ed already.
> +     */

We're enforcing

    /*
     * Multi-line comment
     */

for qemu now; checkpatch should be reporting on that.

> +    if (!env->aarch64 && arm_current_el(env) < 2 && ri->cp == 15 &&
> +        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {

Use is_a64(env) not env->aarch64 directly.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
