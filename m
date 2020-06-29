Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAAB20CDAD
	for <lists+kvmarm@lfdr.de>; Mon, 29 Jun 2020 11:44:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C2CDF4B2D5;
	Mon, 29 Jun 2020 05:44:53 -0400 (EDT)
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
	with ESMTP id 4-1NIBorRePK; Mon, 29 Jun 2020 05:44:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A9E404B319;
	Mon, 29 Jun 2020 05:44:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 991B74B2C5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 05:44:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yv+63EI6yj2G for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Jun 2020 05:44:50 -0400 (EDT)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C4E64B2C2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 05:44:50 -0400 (EDT)
Received: by mail-wr1-f65.google.com with SMTP id f7so12854188wrw.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EnCxWQR4dlGK17uRGckUvqEfHCdPbLpa68UtPHcKKio=;
 b=mH8buiJ8Z9YQlQ6MWJCRSKPtfKnLzVd7FnATCAXB5H2EsItKMPL8iyJnirEFkLGLNT
 G1GEepcJVlII1TYQdAnpyBdZiUMaQz0NstG/6V15LKv9NaWPNzVwWWXtinme2uaEd/Dt
 lOBHz7fUXYwCa9D2gFNkuBdNZ2N0QtXB+Cr6fCP82O9n5ChixE+69yIKrDE+r22xvzDH
 sOnJVjwlpYF8TaoJKX9f2BZWWVYoPcNe3QghjS6UlGzTl+42dTvaL3PQ+TljopUiISgj
 pADxT+CdagK3EQpMU/+igB271MtDZj6ibFcR8yJjs/l/q7VtP8qeavQ3Sxebjd9kS3yF
 jORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EnCxWQR4dlGK17uRGckUvqEfHCdPbLpa68UtPHcKKio=;
 b=RZU5BX5YHY/BSltFPI6IzidYeui8UUrFxH6AftRUMhQi6flOqY9bBNfDdK1b75g01A
 KWjyc6WAzqwI2+kHxuFe3dqzlSApBVzf+gChRiIwEQWbSx1JDmVnwSqK3qN2JUO2Di5e
 6aeJkMHiUypD74RNkwNFE566TT8oCExAnKI8Y6LxZvQ4JKgJ62crH2FPzZLp7AAwlcWe
 s9JkppTATxuqlx9vaQ3xrfdeHun681PREXjD2XtLnNLe4wbVJyFeojvCrwRnRLqOMzyy
 sWnHtZ394aX13sxML2Fra0PaONvUMbl/UyMDXF+f2dJEpxd6XO66n4CVDzeEOSFYjtze
 OaVA==
X-Gm-Message-State: AOAM5300IMnTK6ulZ/xEYotcz64d53KWHIuDggpcNY1GffWiyB904qYf
 O/MNLAmm5vecTk+cYFd4N3QBTg==
X-Google-Smtp-Source: ABdhPJw7+a+Xf/rBOn1a5VfVREyElETwEuCi603BISge1JtQApfU5XGP2oL1GXCZmp+SeX59c23Emg==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr15780758wrr.11.1593423889430; 
 Mon, 29 Jun 2020 02:44:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
 by smtp.gmail.com with ESMTPSA id u186sm28737215wmu.10.2020.06.29.02.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 02:44:48 -0700 (PDT)
Date: Mon, 29 Jun 2020 10:44:44 +0100
From: Andrew Scull <ascull@google.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] kvm/arm64: Rename HSR to ESR
Message-ID: <20200629094444.GA3282863@google.com>
References: <20200629091841.88198-1-gshan@redhat.com>
 <20200629091841.88198-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629091841.88198-2-gshan@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Mon, Jun 29, 2020 at 07:18:40PM +1000, Gavin Shan wrote:
> kvm/arm32 isn't supported since commit 541ad0150ca4 ("arm: Remove
> 32bit KVM host support"). So HSR isn't meaningful since then. This
> renames HSR to ESR accordingly. This shouldn't cause any functional
> changes:
> 
>    * Rename kvm_vcpu_get_hsr() to kvm_vcpu_get_esr() to make the
>      function names self-explanatory.
>    * Rename variables from @hsr to @esr to make them self-explanatory.

I like this; there's been more than once this has confused me recently!

Acked-by: Andrew Scull <ascull@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
