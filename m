Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2417E5AFA02
	for <lists+kvmarm@lfdr.de>; Wed,  7 Sep 2022 04:40:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46A5F4BE1B;
	Tue,  6 Sep 2022 22:40:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4AmFoleJGUh; Tue,  6 Sep 2022 22:40:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34AC74BE03;
	Tue,  6 Sep 2022 22:40:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E19004BDE2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Sep 2022 22:40:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqmFtFUEhI-s for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Sep 2022 22:40:27 -0400 (EDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0426D4BD77
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Sep 2022 22:40:26 -0400 (EDT)
Received: by mail-vs1-f46.google.com with SMTP id m65so3190132vsc.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 06 Sep 2022 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=nRLryB5Xf6lBklSjFILLPLap9evfM0qCWn2PvmAqML0=;
 b=UJVC3Gng8U3UmQUkRK7cXsWmmJL7WkoCXMlUIomBRYjM86jMhNimaEYMGH9NI5etdf
 9dXdbKNrB3zpNZCcS5BDKaFI2z6VCPAUJI2fvx+yODlYzfl7JF4X78Lw2bXsJ110PQBE
 gWjQBfPs2Xv7o7gKddMwPZNmftTqOvcoK3U987SWDvW1PaCsLcXTWJEZgE4dEimJSWOQ
 iNX8zcjUof8AGeIgkZ8aP4qrAr7mK7cOlGo5XemApDnmELEDIjjUxbsKhUc7WCKCKAWB
 5l1qhf/8q+kZvglYXBSvov+hUlZtTqxzGRm1TqvtPO7gsLSZeq93rx1+qAmg3OjPCivG
 JmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=nRLryB5Xf6lBklSjFILLPLap9evfM0qCWn2PvmAqML0=;
 b=lm5X6p7OQTHet9y8JAoHWoBkORTCQzUzq5kMo8cahdNfaCfl2WYQHFHxBdot2jj8P6
 O75JsHfYlGCPiZl0qhro1Z3pIEQT0k8SroMpXwtyEqV77UAsIylvmtOsVTmh9vQe/J4i
 ARZrJ+UkLDDpvYLZEyiVnfqt0VhmbbJIMoqh9LMMZh0gn73jxodx5VUhU0lRH/IGw5rH
 2ArXoXZsMPtxzKqdv+noR8609DAnNZO8K8FD6UKBgtATJZ16Q2M0owReq1IrJv+J7VJm
 LcsQYtq1+qXpPJyzk35F9XTq080Ncs3NpjOuNtjX04QMjrrk6DTs+bZl5ELhvHXfrp1I
 GW4g==
X-Gm-Message-State: ACgBeo1mBCi5KX3MK6cgKwplXobXMEpuz4s4hQC5Q/S1SxAUuGqB8XWi
 ZaUIwZ6RD17INFiKehpGDXtt1weW7c8BKbiomLK66g==
X-Google-Smtp-Source: AA6agR44iTfe4vWGY8NVG62qnMuNdo07u4WWB0Hq3elNrucYrkLoB5SpIfHwPyNFT59Q2eNPmDt6Pc0Rc8oKHU/TE/A=
X-Received: by 2002:a67:fdd0:0:b0:397:c028:db6a with SMTP id
 l16-20020a67fdd0000000b00397c028db6amr477394vsq.58.1662518426470; Tue, 06 Sep
 2022 19:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220902154804.1939819-1-oliver.upton@linux.dev>
 <20220902154804.1939819-6-oliver.upton@linux.dev>
In-Reply-To: <20220902154804.1939819-6-oliver.upton@linux.dev>
From: Reiji Watanabe <reijiw@google.com>
Date: Tue, 6 Sep 2022 19:40:10 -0700
Message-ID: <CAAeT=FwZ28XRgAkUH_aTxZfSPHRRrEUSy8-R-dj6rs6fmOnv0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] KVM: arm64: Add a visibility bit to ignore user
 writes
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Fri, Sep 2, 2022 at 8:48 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> We're about to ignore writes to AArch32 ID registers on AArch64-only
> systems. Add a bit to indicate a register is handled as write ignore
> when accessed from userspace.
>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
