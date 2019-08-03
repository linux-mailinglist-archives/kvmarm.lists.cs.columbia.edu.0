Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82C8048E
	for <lists+kvmarm@lfdr.de>; Sat,  3 Aug 2019 08:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEA704A550;
	Sat,  3 Aug 2019 02:03:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCdbhIViciL2; Sat,  3 Aug 2019 02:03:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2F524A54E;
	Sat,  3 Aug 2019 02:03:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 453A64A546
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Aug 2019 02:03:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfhvWxLucgWk for <kvmarm@lists.cs.columbia.edu>;
 Sat,  3 Aug 2019 02:03:23 -0400 (EDT)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A14C4A500
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Aug 2019 02:03:23 -0400 (EDT)
Received: by mail-wm1-f66.google.com with SMTP id s3so69874225wms.2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 02 Aug 2019 23:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s1Bg7pHVRZHFAIlglq7EJltjZN0ovjw/td6NGQCcl24=;
 b=mgM9+Lf0G0ZR+QjYqYvL2rsYyJzHZjCawsPoRnb5GsFC9e1jBHCzeb/LVwAq6mEPbj
 2jVSjmITBAjUYSTNfddNwS8pTXX1pmsrm2+N9l4GfJd5kpELTglO5A+gnl6EJFqqfyWQ
 e0z2HxRVVvLzLoFdYdS1Ltd1a3v9pr+R8vG3e56OZBI6b4PNXLN+AJ21igNtsV7sCT39
 2uTsV2/Jsc+KawogIQLEQcJX4NF1rW3y6j491yLINrkZNCzkOhijvsaYIEnV6mxX83u7
 1XAxQWngC1XJ/zXJ3aledRJl5LuSB3lqPnoJPF8eNTvhO2GLpU5ZYYsEQUbV02zZJs5A
 6Lpg==
X-Gm-Message-State: APjAAAX8XSfP/3UD0PJlWC8/RkAQIoahV/BtQo63E6F/xpy+TzVN1SJa
 N7u4Af+VOxqbA4BX+OukISPtbU9TKwk=
X-Google-Smtp-Source: APXvYqz5a01CMllxqdzGgPoACQ+37QCcaKarUxj3ZZwq005RfxFUYDLJnKSjixfp55XQ79bozzthUQ==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr7819593wme.177.1564812202139; 
 Fri, 02 Aug 2019 23:03:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id c30sm146927959wrb.15.2019.08.02.23.03.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 23:03:21 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] Force GCC version to 8.2 for compiling the
 ARM tests
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Drew Jones <drjones@redhat.com>
References: <20190730121056.5463-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9db8130-0215-9aba-5687-c23b1128d8e5@redhat.com>
Date: Sat, 3 Aug 2019 08:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730121056.5463-1-thuth@redhat.com>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu
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

On 30/07/19 14:10, Thomas Huth wrote:
> The kvm-unit-tests are currently completely failing with GCC 9.1.
> So let's use GCC 8.2 again for compiling the ARM tests to fix
> the CI pipelines on gitlab.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a9dc16a..fbf3328 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -17,7 +17,7 @@ build-aarch64:
>  
>  build-arm:
>   script:
> - - dnf install -y qemu-system-arm gcc-arm-linux-gnu
> + - dnf install -y qemu-system-arm gcc-arm-linux-gnu-8.2.1-1.fc30.2
>   - ./configure --arch=arm --cross-prefix=arm-linux-gnu-
>   - make -j2
>   - ACCEL=tcg ./run_tests.sh
> 

Queued, thanks.

Paolo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
