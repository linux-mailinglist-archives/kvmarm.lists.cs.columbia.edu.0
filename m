Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4A4043CD
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 04:55:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD3914AC80;
	Wed,  8 Sep 2021 22:55:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ifm7jmXlz4xs; Wed,  8 Sep 2021 22:55:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDEE74B0C5;
	Wed,  8 Sep 2021 22:55:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA4834B08D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 22:55:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2IoWC6DUqJ0G for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 22:55:45 -0400 (EDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 12AC44AC80
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 22:55:45 -0400 (EDT)
Received: by mail-il1-f182.google.com with SMTP id x5so455709ill.3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=70g9MtOxJ+c9WQaUJGlWTIEgCLNxdZNwZARtMaXCcgM=;
 b=fybdFrS1IowdAXfYbxOXZ3I6iSICWHOoF9IqHePDV3JYI5GmKvgKKa90x5sb5L8SYR
 9szwaRfJMm9JfBRUgGGY3YY12Mjuc+rk2CbaIqEdAE32pvpey8S5NzpVoqHHXoJoizU9
 Y4m0MBUqxSXXIpH97d7OQLDeqGByZe+DbZDDbBDInbxLt8uB2fzneSrc+2gXDZ6qGE7k
 UtVvjlpHQ5cpq/I/6xiR7ftkjaNaD1UCpUlyMn/WeV1wyAJhooWq7AgiBdv15eANHjag
 wv9n6hADOzo+d0E/yh8ZUZBX4YFEHDZJ9eQixJtbt9LixnwUWFrLJ9+yU+ejmrjmnr5b
 qvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=70g9MtOxJ+c9WQaUJGlWTIEgCLNxdZNwZARtMaXCcgM=;
 b=BpoA1ldeaYF5LtVk2vWNpK0gZLiYIUZD15XA6zeRqxqzPQIoiNgxpOr+kWJZjdRzGj
 8nGYs9bJb6/K3Yyo/Q3ZQN0qTP5xvEpeFCf8wteh8jwFfeT8SC0uH07mgPtyzZTSXtlc
 szfhaTjvsfCfjv6Vzdxv1jcVnA6ElYBSU/x5InmnmadtBYx1uMm0ydikb7nRSs9R75c2
 AkSRIaqV8nYpu5hCuE2RtbyNFslmg5fnxsGYfOV/AT75WdkE4sgY9pQ8KfG8Pnc6gn80
 3P7jOIK+XVXAF/odOhuRZVdCugmFL3NPTJBiwfgdDFJAw4jxgjxhnCIMIMmRQrNlrDII
 i1CA==
X-Gm-Message-State: AOAM532g/AXbsuPtcwgp3FKBexFkBrNfQxY0pnqNjiR1eGuhslNJ0klB
 AAmcizMJ9x65vyPuRo/f8/8htw==
X-Google-Smtp-Source: ABdhPJwe5z4yVVGtg+ZHPkN6LiNEnHan8VvEXYzBBzUdrsrQl6RJRGqbPl1NpgQBsDKzC/M6vmVW7Q==
X-Received: by 2002:a92:6907:: with SMTP id e7mr563449ilc.301.1631156144318;
 Wed, 08 Sep 2021 19:55:44 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194])
 by smtp.gmail.com with ESMTPSA id a2sm259247ilm.82.2021.09.08.19.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 19:55:43 -0700 (PDT)
Date: Thu, 9 Sep 2021 02:55:40 +0000
From: Oliver Upton <oupton@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 03/18] KVM: arm64: selftests: Use read/write
 definitions from sysreg.h
Message-ID: <YTl3rP50dYjvmmDP@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-4-rananta@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-4-rananta@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, Sep 09, 2021 at 01:38:03AM +0000, Raghavendra Rao Ananta wrote:
> Make use of the register read/write definitions from
> sysreg.h, instead of the existing definitions. A syntax
> correction is needed for the files that use write_sysreg()
> to make it compliant with the new (kernel's) syntax.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/debug-exceptions.c  | 28 +++++++++----------
>  .../selftests/kvm/include/aarch64/processor.h | 13 +--------
>  2 files changed, 15 insertions(+), 26 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 96578bd46a85..bed4ffa70905 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -8,6 +8,7 @@
>  #define SELFTEST_KVM_PROCESSOR_H
>  
>  #include "kvm_util.h"
> +#include "sysreg.h"

#include <asm/sysreg.h>, based on comments to 02/18

Otherwise:

Reviewed-by: Oliver Upton <oupton@google.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
