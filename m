Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 824DE449A0E
	for <lists+kvmarm@lfdr.de>; Mon,  8 Nov 2021 17:42:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 018CE4B128;
	Mon,  8 Nov 2021 11:42:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3g3GuFWUpds; Mon,  8 Nov 2021 11:42:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D580E4B11C;
	Mon,  8 Nov 2021 11:42:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 59FE14A98B
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 11:42:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hBvutmqQ+uF for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Nov 2021 11:42:26 -0500 (EST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A847049F6C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 11:42:26 -0500 (EST)
Received: by mail-lj1-f176.google.com with SMTP id d11so9484783ljg.8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 08 Nov 2021 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=1RLseEUQlyKP3OtVAFvB8W7OpMujrWu3c5H028Em2Gg=;
 b=W0oMOq/t7OdyrV2oNkFlRoGSclw83ax39QpHBgPMQPvQqAth3oMcmPecroRdDGTazE
 DKuds3Mh4MBP8NQRbHmW2YRqns2BxI5ZurpOmVar1zeXQKc1Yz7AVEj6KM9JZHc1oIqY
 hzI2z3zhqz50UxybDTOsdf9uBXn4pBeSyPxDlUC7yEdl2lxxvZZZSNyXjXgrQjwuMeD3
 oyLaZwrAhlGaCi6bd6vY/womDTpBElaCBF4nZxpgH/4P1DcZmIMKocYsxE9/FzA9Zlmi
 JtVYcBIN0R69CuM3pdrn8T2ekvRbkaJQ63ng7hAzec1HZslB6eO2kguqFkrvcRDUP/1M
 KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=1RLseEUQlyKP3OtVAFvB8W7OpMujrWu3c5H028Em2Gg=;
 b=Ly7qCpS7nUZ+on/O45DieC0m42vJ7q7RUIXtWEV5EjoyGEprCtH0zf7qZqEuCQpseU
 hnOylkSM3LhAVat/NQTmaQ1fbG3B3mqoBrdg/DlPh9Aes6N0vqm6q6HyQJabsaevIaWf
 ygVSeiBwP4puuPpG1F0Yh/y/PrDGeRb+1ImI1Ruj8Wtsn3h5VZJbvQ8Bt/Yx9ti8U2qU
 9BTvl57IA+tBxWRGxpeWQBATRS1FLtbVn27z8mu7BqVa4cs7rFrwoYZc5DWxjnJQoWiV
 VbKY+gtogFm/3AzfH4hJmKG3/ax5lW1J4PALJxaR87in3N119/VwAXyxHM9E5kM09arZ
 AKHg==
X-Gm-Message-State: AOAM532/6HzxF+lFEXXhGGc5+1FGUsjMGqD2YMDj3X92bimFTGt7O6I6
 ItUrVOp7xR1lNrbELhewt9EGaNjBH6FJ+LB2i6JGGCQz
X-Google-Smtp-Source: ABdhPJyxqA1qOBlAOj99g6xktVhX9R21NGTLi4IMPA5g0hYYUlGK8QVnMdZ1tLT09O7f8XlSGLq8XscT3vHz46UVypE=
X-Received: by 2002:a2e:8107:: with SMTP id d7mr371264ljg.376.1636389745192;
 Mon, 08 Nov 2021 08:42:25 -0800 (PST)
MIME-Version: 1.0
From: Chenxu Wang <irakatz51@gmail.com>
Date: Tue, 9 Nov 2021 00:42:14 +0800
Message-ID: <CAFLP=uBWCsV3A_9BnUiyA05_kwg5e8XCSgVOaSX8MZMZjdKCpw@mail.gmail.com>
Subject: How to translate a VA in Guest to PA in Host?
To: kvmarm@lists.cs.columbia.edu
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

Hi all,
I am trying to translate a Virtual Address in Guest OS to the Physical
Address in Host OS. Currently, I enable the VHE extension, so the Host
is in EL2. I also enable EL2 Stage-1 translation and EL1 Stage-2
translation.

In my experiment, I first get the VA in Guest OS. Then, I generate an
exception that will be caught by Host KVM, and send the value as a
parameter to the Host.
In KVM, I want to use the "AT S12E1R" for this value, but it failed.

So, does KVM implement some API of it?

Sincerely,
Wang Chenxu
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
