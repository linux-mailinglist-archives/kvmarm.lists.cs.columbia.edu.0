Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 339A6185F12
	for <lists+kvmarm@lfdr.de>; Sun, 15 Mar 2020 19:36:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 475DC4B089;
	Sun, 15 Mar 2020 14:36:02 -0400 (EDT)
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
	with ESMTP id mhGZNrpq73dW; Sun, 15 Mar 2020 14:36:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 211EC4B087;
	Sun, 15 Mar 2020 14:36:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFBC14A3A5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Mar 2020 14:35:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ncq-KPNmYwIv for <kvmarm@lists.cs.columbia.edu>;
 Sun, 15 Mar 2020 14:35:58 -0400 (EDT)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C82F94A32E
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Mar 2020 14:35:58 -0400 (EDT)
Received: by mail-io1-f67.google.com with SMTP id h8so14878348iob.2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Mar 2020 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c6rvGe6qiS9edty2AHSQkpLqwQdVmf0ROJL+Sl14+QA=;
 b=pPrcmkrzdcHQTPq55B9yoiAh8RYJbva9CDfetb/a/JiRGBo3MVMoQHYrO5MBPxJaNg
 VyNeCK9wTgW6572156e2NbRcnEaL5D/oBlMuejCAQZX1aBPOxPWK1kcK6v8z5d5zr8ih
 vXc5C3FF52nGEaFg8C71vLEabHJDmJVsBkAa6Z8ACPioqR4b/FCTEJvHJ25Md3UGa8Ah
 2D7DGAmyJgi/4rzghZhcfPyEzc6G+jfQx+voUNSfFDq9GmD37ZGCxM6EzE8HKFatE6dY
 hEpGyUfQEkxN39rExvyyVMSPQZq7mlTaGlmTuZJHfW9+QA5u+3w6sIOeEZBDRfOF3XNo
 gQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6rvGe6qiS9edty2AHSQkpLqwQdVmf0ROJL+Sl14+QA=;
 b=kMdqOXjGKdztr6wiaBZJotSxUXzxnIFCDsp0g7m8oSw4PJEulwuwb31A1scS8QR45A
 ySc2l1NrfTAcP/r8cmIgGp6OTVsAYrhaI5J8+fHLvDVCv7znfIjXkDTcRnwMlXENz2NS
 7cKF2FpEbZEPR8by1Fhk8Kxlkq3GIvA7y4A75fZPDOTMN69OjNn1dEF/Yanogc9jzsaP
 y/SOhG5oZoUEkhuxD2fU9eI1XwC7ZY+H0454cW+X0aRXFixzi+uEhbJ00A/6UzRHOrHC
 Opn8fjaX1opTWgNaxmksb+grc6u+tLuDo/5I/QV9iZ4zQLBi+rD4xLS6Sopxp3VDiHn2
 YPDw==
X-Gm-Message-State: ANhLgQ1np8rvqfpyO6bbCFMQ0Oo6IdstcBOxvBMhSvyIaxeGD9z9DJey
 nAN/k4TbOotJBOd3lcF9sYe7J31A+igy623bV2bShQ==
X-Google-Smtp-Source: ADFU+vuN2xGw3Yo9Y0hRVQ6IxMH7tUTZtyjNfgim+GPkr7Ppg+3AD/qi6U+ErJMb4OaNOV4p/4PVJi9euN7xvJlaAgU=
X-Received: by 2002:a05:6638:102:: with SMTP id x2mr5910753jao.5.1584297358066; 
 Sun, 15 Mar 2020 11:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-2-beata.michalska@linaro.org>
 <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
In-Reply-To: <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Sun, 15 Mar 2020 18:35:45 +0000
Message-ID: <CADSWDzuUC70uNyv5Gad2tC47wHS4jC5Lm7u-hu1fa=raKQXFHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage
 of sync
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, 12 Mar 2020 at 16:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 12 Mar 2020 at 00:34, Beata Michalska
> <beata.michalska@linaro.org> wrote:
> >
> > KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> > As such this should be the last step of sync to avoid potential overwriting
> > of whatever changes KVM might have done.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
>
> Hi; I'm going to take patch 1 into target-arm.next since it
> seems worth having on its own and I'm doing a pullreq today
> anyway. Andrew's given you feedback on patch 2.
>
Hi,

Thanks for that. Will drop this one from the next version of the patchset
once I address all the comments.

BR
Beata
> thanks
> -- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
