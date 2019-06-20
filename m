Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D04CD02
	for <lists+kvmarm@lfdr.de>; Thu, 20 Jun 2019 13:39:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37FD34A503;
	Thu, 20 Jun 2019 07:39:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zvd9mgBUHGkT; Thu, 20 Jun 2019 07:39:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B29E4A483;
	Thu, 20 Jun 2019 07:39:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D8554A4F4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:39:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FGEX5V1cE4a for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Jun 2019 07:39:02 -0400 (EDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 172684A418
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:39:02 -0400 (EDT)
Received: by mail-wr1-f42.google.com with SMTP id d18so2685089wrs.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 04:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=trRXLLHyis6AvlgnEySANQEBoGJgqpN6zwf2piWO27o=;
 b=AEzHJWBQZVjfHEeEXUaWMFjQDi2GGcDDFZDu3aERJE628cOwnMDt6QPumHk00kTRQq
 TE9K1VV9VLq3zTwalV9xCdHSLQ59Y47Wwa5FKeJUEtIOWqc1UPEwaYc9I0F4DKjNQKpR
 JPfwCnc0COs4mo3+MStbpK6REYb3eosdFKnevmCZZrMv/XjuaDIgqFsvsXkAKWqP98J/
 iIQbZVVtf4Aj8afwFaJ/T4wSs4OnAVlO96dvoc7z0NzuXQDhQI+nLePOC0L5AP6nJAeq
 sZeDFc04QTS5aisl3Zgpi50cafS2Z+UKGuE0WJf+PLyf0pc1VaSH/p0A0t9WZUCzrENI
 Z0HA==
X-Gm-Message-State: APjAAAWwQDFAxzncJviKVOgKRLXFYStEPLdwXpUk08Ng5OWFubQy03vz
 9jNxTNvt1t/Adh9kg6puPwnHGA==
X-Google-Smtp-Source: APXvYqxdeCsF4SekbEa5L2K2atxBBUp3jIOusAd4PtSB6TjbQL1gtxx/JbT0Vs9Sc4hlqnTGGz/Tiw==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr77757892wrj.103.1561030741150; 
 Thu, 20 Jun 2019 04:39:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id x8sm4349824wmc.5.2019.06.20.04.38.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 04:39:00 -0700 (PDT)
Subject: Re: [GIT PULL] KVM/arm fixes for 5.2-rc6
To: Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <20190620112301.138137-1-marc.zyngier@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <685d31ae-b854-96f2-4bbe-5a863c291491@redhat.com>
Date: Thu, 20 Jun 2019 13:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620112301.138137-1-marc.zyngier@arm.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Dave Martin <Dave.Martin@arm.com>,
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

On 20/06/19 13:22, Marc Zyngier wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-5.2-2

Pulled, thanks.

Paolo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
